Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF553D389
	for <damon@lists.linux.dev>; Thu, 18 May 2023 19:29:19 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f42397f41fso355e9.1
        for <damon@lists.linux.dev>; Thu, 18 May 2023 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684438158; x=1687030158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIFdF8GT7zUenP4B/UoN0byarsJ8CzDEiV0NqRPRUiQ=;
        b=Uxo5R0yZohoUeJJFTQrwM/0iDUM8s/ZhBeLXvqBwIGBhosJvSUZY/pVw5D/kK5YqBX
         t0YUZ9PJRPbSBA1cAXgrFlmyRu22QDs2vk9LwoS1Vc/BLgT33eNrFh2gR7RMixMdU9pF
         8P01mTJth058rQOO5TmeFThj0TmYFHxendJ35CKKe0wpv+KSFOx9FbGk+vSsbmtjdJmF
         MoKqNialoSnEDU27YOgQHSeSfgbH3RwmpqCCAHYQW9TQlFT8KOxl4iLKhN8Q4nRG0k3C
         vTIffa26u7CrKoYTKHxbPYN7OQkEBh7C7utYywfWTfxfYempEHiTHfbsjZAafRzuys/3
         coEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684438158; x=1687030158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIFdF8GT7zUenP4B/UoN0byarsJ8CzDEiV0NqRPRUiQ=;
        b=Q3lmjlW0LUIV7J6lV3S/xHJ6I9cKzdCogRf5scs8TCY2dfseR85A7QIhoO3TqgvzzV
         Pft51sg9heq9p0wdlTSpqbsWc8kK7kF1mAGtEeAyx9wDZEtu10fSup/UIb8/d1TpYyew
         C5QvttbXS7UvE/QCtFmwc2O5lHQJ0B8ERXSo0dlGS9sU78dIZWfoDdSf+I9caigGWvHz
         MtojGSAh3bbjyBs13oqa7TuER2wRUp+Mk1TsYNKpaRiF3e1tdgPUOHWdOBlKwCyI7don
         tGc7eqROyeoHb9CqDP2w5G2crSo9Z+qYydxQSOSrkKjCT0OwiBZe1IpZnEen2gjCwJxI
         OhCA==
X-Gm-Message-State: AC+VfDws2rPbyQE6KmDkJrJNsTqQpKPO9va5ig4AU8uVunm4PScxa1/u
	4vno8ITl91J1gr0Gz/LglPZX8K9dnBQfMlX+PZnzHw==
X-Google-Smtp-Source: ACHHUZ5CjeOl+/lEZTX8Uee0Ftthe9E4dunYZK5dMRfMgke26RmSp2LBtvDHRXHjW5Kbw5GABsfsakJxT5P3YD+q7Z4=
X-Received: by 2002:a05:600c:46d0:b0:3f2:4fd2:e961 with SMTP id
 q16-20020a05600c46d000b003f24fd2e961mr3080wmo.0.1684438157716; Thu, 18 May
 2023 12:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230518110727.2106156-1-ryan.roberts@arm.com> <20230518110727.2106156-5-ryan.roberts@arm.com>
In-Reply-To: <20230518110727.2106156-5-ryan.roberts@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 18 May 2023 13:28:35 -0600
Message-ID: <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 5:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> There are many call sites that directly dereference a pte_t pointer.
> This makes it very difficult to properly encapsulate a page table in the
> arch code without having to allocate shadow page tables. ptep_deref()
> aims to solve this by replacing all direct dereferences with a call to
> this function.
>
> The default implementation continues to just dereference the pointer
> (*ptep), so generated code should be exactly the same. However, it is
> possible for the architecture to override the default with their own
> implementation, that can (e.g.) hide certain bits from the core code, or
> determine young/dirty status by mixing in state from another source.
>
> While ptep_get() and ptep_get_lockless() already exist, these are
> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
> So rather than using ptep_get() and risking performance regressions,
> introduce an new variant.

We should reuse ptep_get():
1. I don't think READ_ONCE() can cause measurable regressions in this case.
2. It's technically wrong without it.
