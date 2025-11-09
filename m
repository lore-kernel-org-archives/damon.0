Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5D34D390
	for <damon@lists.linux.dev>; Sun,  9 Nov 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692584; cv=none; b=haNw865++SRjRKWOW8cBa+1uOONrUXrB/MwKWycODvFHyr0/NNHS6yCkrgnF30IDY6lXEo5nwKV4ea+zoxs4irjyqGgKr/c6E2fy6b/2Q5loccgvbevMIBVUxnpVZ4zogPzf0CbrJgI/3t9Xw6vfyuTisfYs7/clUi0zFC3LdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692584; c=relaxed/simple;
	bh=JF2q7sTKzYiIVusFfVQ6qlbWbep+D+t1c3S+sk6voF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/lvGsfzPkwFjOZubeHnTPHm+4p28sqJKoHnfIvKQIWaaccKoh60htQrntztX3iuyMvkBOg8CnbspWHE4MtksZV0Kzx9r9kdg+w6qYnW9zr5tZgo5qcIrR64RWu32lqNQQJ1r3cx8UlX1AIthtBOMyAH9F/34UPk8ctHICdZaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyIVkjxj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyIVkjxj"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so337130066b.3
        for <damon@lists.linux.dev>; Sun, 09 Nov 2025 04:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762692580; x=1763297380; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDZ3xafdhT/YtTTUoql25uDvUJxupIOBYIVvt5riwwA=;
        b=NyIVkjxjy1vp9fhRo/AvJHcXy7SA/5QkQ5+qUKDjITf/O5Fss+1O5jTx0VJ5uzBmSj
         ZI/i9/aLofuLMmc5ayjvYGvwjGKjGth5uj+YXEDrUR507J2m7H9qKQLReEnojda2ShyY
         O07MTEqIJUfVX2zNn3lAS1fYxDUV96omQnIDzUueD9bk7s1KIPh6bFbSOHiZvVX9dvCq
         xlquqiy4bLAddvwNMwizHTrTfxYbi0XFV0+L/GIXweAv2JMOZTJkMgCy47nzA90LECyM
         FtmAiG+jB8hSqmIkcIPh1GTlV85GHtIowNYFjCEryEHgC5Mk6ttBAdBv7EbZ1YhssrcA
         6EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692580; x=1763297380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDZ3xafdhT/YtTTUoql25uDvUJxupIOBYIVvt5riwwA=;
        b=SacE+dQIwI3moc6sMgV6MrsEorxwN4H/IDcjtI+F6JpPrJ2S/tbjWfgLRl/O24m9Cj
         SLVGM4qVtyFj7myXW/BT13sEkIt8u2hkLXosat3AUTSyZZwE9nTLZykh8hukKPQiefnK
         zDlUXdJiG5F5GKF6n9jtlm5xqPM55eBgsXKAUruoFZ+zthi38VlE6Ii1Io1l3cFEGi09
         caSAyaxsZQo139TkTe0Jg1YXJP8XXkr17ZFO/ZdXHtJ5VQ2MWBHAeS/p6oDgn2bRnXWv
         R6lQj0NCMtKB0XKc0KJGlQzDU6W7HtyGZtBvgmwibA+xWiXTXyjC6dMpcimo40+Lq6u/
         tQRg==
X-Forwarded-Encrypted: i=1; AJvYcCUAwFpOcLueTguGmOyHsP34NgIm3q89+d0icP9C7CLP2MoFNu72kdrGOvCeJiroA1/J2vlRhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP4/TFrvw+H437+VxdGvBbZDMkEI8mxU+aAzPYOM57BrZ9WLu2
	85MpSEhV2i8idbXZlqUrtzVRq4/MBa6F57jU6wM2yAco3bcKHYaa5hBIAH2NZZdKb1FDnQGiJk7
	CDWbiiy3JWQshaTyB6JSGzcDNAATUP8M=
X-Gm-Gg: ASbGnctUiAXpnepS6N+ofg7TgedwQs6B6BQQ320Io0G5aATbtDZZubU9wY9nzi30Bow
	QocsuhNVu9dLZQqxFjGXlLFyXFq+uA+2xYU8h+GsiB8Ge9b0xODlR4NzguUjN//qMI6SM0F8eWn
	6TeJFoizYU3WcBN0fAzDGZ4uVLUr1sQkx/tzdD7m97YV+NwoUJXCG4aDOi7IoQ8i+B6dPw+k7aa
	WV8grIrmIV6bbmwKrkFuz8W3prOKwIVG/0lfVJezcR6VD+YjCxK4TftHhj5
X-Google-Smtp-Source: AGHT+IHNVHcrPcoXcfMQAdrM6mfxVNIvqirPfSk4ZwLH/WJQN1X+/EwZuiwM1z9Tvembh+GaQUpS/PpKFfhnQ7ESKbE=
X-Received: by 2002:a17:907:869f:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b72e058a781mr441932566b.55.1762692579280; Sun, 09 Nov 2025
 04:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <75c2e8fa38de383757a49bcc3f5c081be1e27a40.1762621568.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <75c2e8fa38de383757a49bcc3f5c081be1e27a40.1762621568.git.lorenzo.stoakes@oracle.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 9 Nov 2025 20:49:02 +0800
X-Gm-Features: AWmQ_bm7gm65mOXTd2rtxZ-2sSA2POMXyYBKPT6giX8icbqtDuQMmyxTTsU5nEc
Message-ID: <CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD29HiNC8OrA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] mm: eliminate is_swap_pte() when
 softleaf_from_pte() suffices
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 2:16=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> In cases where we can simply utilise the fact that softleaf_from_pte()
> treats present entries as if they were none entries and thus eliminate
> spurious uses of is_swap_pte(), do so.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/internal.h   |  7 +++----
>  mm/madvise.c    |  8 +++-----
>  mm/swap_state.c | 12 ++++++------
>  mm/swapfile.c   |  9 ++++-----
>  4 files changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 9465129367a4..f0c7461bb02c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -15,7 +15,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/swap_cgroup.h>
>  #include <linux/tracepoint-defs.h>
>
> @@ -380,13 +380,12 @@ static inline int swap_pte_batch(pte_t *start_ptep,=
 int max_nr, pte_t pte)
>  {
>         pte_t expected_pte =3D pte_next_swp_offset(pte);
>         const pte_t *end_ptep =3D start_ptep + max_nr;
> -       swp_entry_t entry =3D pte_to_swp_entry(pte);
> +       const softleaf_t entry =3D softleaf_from_pte(pte);
>         pte_t *ptep =3D start_ptep + 1;
>         unsigned short cgroup_id;
>
>         VM_WARN_ON(max_nr < 1);
> -       VM_WARN_ON(!is_swap_pte(pte));
> -       VM_WARN_ON(non_swap_entry(entry));
> +       VM_WARN_ON(!softleaf_is_swap(entry));
>
>         cgroup_id =3D lookup_swap_cgroup_id(entry);
>         while (ptep < end_ptep) {
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2d5ad3cb37bb..58d82495b6c6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -195,7 +195,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned=
 long start,
>
>         for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
>                 pte_t pte;
> -               swp_entry_t entry;
> +               softleaf_t entry;
>                 struct folio *folio;
>
>                 if (!ptep++) {
> @@ -205,10 +205,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigne=
d long start,
>                 }
>
>                 pte =3D ptep_get(ptep);
> -               if (!is_swap_pte(pte))
> -                       continue;
> -               entry =3D pte_to_swp_entry(pte);
> -               if (unlikely(non_swap_entry(entry)))
> +               entry =3D softleaf_from_pte(pte);
> +               if (unlikely(!softleaf_is_swap(entry)))
>                         continue;
>
>                 pte_unmap_unlock(ptep, ptl);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d20d238109f9..8881a79f200c 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -12,7 +12,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/mempolicy.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/init.h>
>  #include <linux/pagemap.h>
>  #include <linux/pagevec.h>
> @@ -732,7 +732,6 @@ static struct folio *swap_vma_readahead(swp_entry_t t=
arg_entry, gfp_t gfp_mask,
>         pte_t *pte =3D NULL, pentry;
>         int win;
>         unsigned long start, end, addr;
> -       swp_entry_t entry;
>         pgoff_t ilx;
>         bool page_allocated;
>
> @@ -744,16 +743,17 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               softleaf_t entry;
> +
>                 if (!pte++) {
>                         pte =3D pte_offset_map(vmf->pmd, addr);
>                         if (!pte)
>                                 break;
>                 }
>                 pentry =3D ptep_get_lockless(pte);
> -               if (!is_swap_pte(pentry))
> -                       continue;
> -               entry =3D pte_to_swp_entry(pentry);
> -               if (unlikely(non_swap_entry(entry)))
> +               entry =3D softleaf_from_pte(pentry);
> +
> +               if (!softleaf_is_swap(entry))

Hi Lorenzo,

This part isn't right, is_swap_pte excludes present PTE and non PTE,
but softleaf_from_pte returns a invalid swap entry from a non PTE.

This may lead to a kernel panic as the invalid swap value will be
0x3ffffffffffff on x86_64 (pte_to_swp_entry(0)), the offset value will
cause out of border access.

We might need something like this on top of patch 2:

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 1376589d94b0..49de62f96835 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -54,7 +54,7 @@ static inline softleaf_t softleaf_mk_none(void)
  */
 static inline softleaf_t softleaf_from_pte(pte_t pte)
 {
-       if (pte_present(pte))
+       if (pte_present(pte) || pte_none(pte))
                return softleaf_mk_none();

        /* Temporary until swp_entry_t eliminated. */
