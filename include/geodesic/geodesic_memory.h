// Copyright (C) 2008 Danil Kirsanov, MIT License
#pragma once

// two fast and simple memory allocators

#include <memory>
#include <vector>
#include <assert.h>
#include <math.h>

namespace geodesic {

template<class T> // quickly allocates multiple elements of a given type; no deallocation
class SimpleMemoryAllocator
{
  public:
    typedef T* pointer;

    SimpleMemoryAllocator(size_t block_size = 0, size_t max_number_of_blocks = 0)
    {
        reset(block_size, max_number_of_blocks);
    }

    ~SimpleMemoryAllocator() {}

    void reset(unsigned block_size, unsigned max_number_of_blocks)
    {
        m_block_size = block_size;
        m_max_number_of_blocks = max_number_of_blocks;

        m_current_position = 0;

        m_storage.reserve(max_number_of_blocks);
        m_storage.resize(1);
        m_storage[0].resize(block_size);
    }

    pointer allocate(unsigned const n) // allocate n units
    {
        assert(n < m_block_size);

        if (m_current_position + n >= m_block_size) {
            m_storage.push_back(std::vector<T>());
            m_storage.back().resize(m_block_size);
            m_current_position = 0;
        }
        pointer result = &m_storage.back()[m_current_position];
        m_current_position += n;

        return result;
    }

  private:
    std::vector<std::vector<T>> m_storage;
    size_t m_block_size;           // size of a single block
    size_t m_max_number_of_blocks; // maximum allowed number of blocks
    size_t m_current_position;     // first unused element inside the current block
};

template<class T> // quickly allocates and deallocates single elements of a given type
class MemoryAllocator
{
  public:
    typedef T* pointer;

    MemoryAllocator(size_t block_size = 1024, size_t max_number_of_blocks = 1024)
    {
        reset(block_size, max_number_of_blocks);
    }

    ~MemoryAllocator() {}

    void clear() { reset(m_block_size, m_max_number_of_blocks); }

    void reset(unsigned block_size, unsigned max_number_of_blocks)
    {
        m_block_size = block_size;
        m_max_number_of_blocks = max_number_of_blocks;

        assert(m_block_size > 0);
        assert(m_max_number_of_blocks > 0);

        m_current_position = 0;

        m_storage.reserve(max_number_of_blocks);
        m_storage.resize(1);
        m_storage[0].resize(block_size);

        m_deleted.clear();
        m_deleted.reserve(2 * block_size);
    }

    pointer allocate() // allocates single unit of memory
    {
        pointer result;
        if (m_deleted.empty()) {
            if (m_current_position + 1 >= m_block_size) {
                m_storage.push_back(std::vector<T>());
                m_storage.back().resize(m_block_size);
                m_current_position = 0;
            }
            result = &m_storage.back()[m_current_position];
            ++m_current_position;
        } else {
            result = m_deleted.back();
            m_deleted.pop_back();
        }

        return result;
    }

    void deallocate(pointer p) // allocate n units
    {
        if (m_deleted.size() < m_deleted.capacity()) {
            m_deleted.push_back(p);
        }
    }

  private:
    std::vector<std::vector<T>> m_storage;
    size_t m_block_size;           // size of a single block
    size_t m_max_number_of_blocks; // maximum allowed number of blocks
    size_t m_current_position;     // first unused element inside the current block

    std::vector<pointer> m_deleted; // pointers to deleted elemets
};

} // geodesic
