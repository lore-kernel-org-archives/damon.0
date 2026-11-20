Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795168432;
	b=Ifxs1g69GnsgTP6mQWsdi0VW+ZQatWGke4CIiDtGtm4LBzH2xayTupu8NTUC3gZzR6mv
	 gQI36SH2sO5e9H7nxNYwRb43jW+D90TwQ0DrupJTP/2Fz6ouAtN5T5zZkCn/FzN4+SrBc
	 w/HgdRripRJSZ1mfqtMI8E+4a8oP7Dy7vxJbBQY3WVJfL+RnZPYWM1SE1YLhVVTuOAUYd
	 KUOpF2AcwfrYwhhOMLFWnQF2xKgXXVGA5kYTHCjQdPhsBounDGiTLprcoVdUCWvRjMigU
	 4t10Vqe2pqsbLFi8KD2Ed/rC4MVO3irOxgbZdwQ4FDMXCxsH70QkuMBRQefWYCOKUBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HAfymCHccjaSnDwBzcAFu1I4f93kNUDtOAKH0uubUTk=;
	b=V87yeg4alRscaRT8p+BPJlzBlTuvk65Z3uG8OU6SDF0RnKWdzaee0hHvyi80G2YJCbt9
	 JTzd1olAqcPW0xBiwj1ITcPTfq1OU1zKHCdm2FjHC3qPdfLYfOr4zmOly/nIAH3RsK+Wf
	 RvEdgg5tBxnj+5pHUfJiq2eUbKbcUsdLoGucMpA/Klj37Wr5gTRube4RIAjfG8CFGYb+X
	 D+t+iH5gNWc7WULMsEn2e3R4ZmAj1GoRAg7Sb1Vb57QFP7UWosOgVPnBOlwWTJ3aRZ18W
	 dOsSTIzSuEGOfmd8RpNEz5jKOuwOjXNQqWLW+Kf1vJF+ZgIX59lHaH6pCAQ1pITz1ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pR0+K0Vk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62960A2637
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 09:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A62960A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pR0+K0Vk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so6743735e9.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 01:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795168429; cv=none;
        d=google.com; s=arc-20260327;
        b=Http1xpm7hC/A/dY9UGKlR5t0orYoAl2ERmUEjs6FcWEbazQe3kxFybvC94DU/7XQp
         os12ngeBkfl2k1wMFBj9yo+5waoLntGQtsMzsMs7VxXUzd7n5tmXO4/u1TneVeXMkAcx
         NAYB5wF74f9o+MemvismbZMgliQebrQR7NrwNg85lTmGws4bYH3CDISBzXYjsK8ORJwS
         DBZNcNtwPqN/njcNP9ji24vWZrTWqrshKlIGLTOzE6tTf5S6cPjGg2dlrr77NU4155+h
         mjPEu+14OtRC6joU82F0P4jLVA2yaKofvLwmU2losfitviXrSBjGGlsjAkqYgHWLHiQu
         eb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HAfymCHccjaSnDwBzcAFu1I4f93kNUDtOAKH0uubUTk=;
        fh=oo5YFPDg2hujVcKPVpdH21qOz/VTNWbWpXoA/eBVJJI=;
        b=BTk3Ww6+yulf0WW83hUjXZildXWOy/2NqsQw3C0WhxDyun0ElOEys8406w3A9HLeJz
         LeIIwYwPAqXA/WSbSCa0tKBYGWQaIVQpW9020PCX/tvNRb4leKS4TEK1Nj4KgHFZOyeO
         zOANdqbJXQd6oNWj21513a+hUhgAuIHpx5RlHthpJLYwcK5kN1dgDRLdAcxOccYRS5xv
         SX0c7ohkXcEf+Faun6nI/jaQN10iF1Sv+V7lVwGGIs/HugaaA2BM5GC/WcM1/8WOSi7f
         YLZGdMcTcTXmQaWRUDri7mFuZSPb/FeHuPf836U84OO77X3Dcyy92UoqtoWy3i3cmOFe
         RFdg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168429; x=1795773229; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HAfymCHccjaSnDwBzcAFu1I4f93kNUDtOAKH0uubUTk=;
        b=pR0+K0VkUJ2NegQKC7SaqBR6UWZwfjVPArEGyPsAhutF1YhKlBJpkUCbPw59zfflPl
         LwAkl0MteJ13iZi8Gjs0t2aiHF9sKi+QWq4TqqM06pB2ag9xnC/ZRyDYkduXq5GFi6CY
         yFFNIc9MLEHwszXiohlPrIIagnpB1rtwk2kra2SOTG2i3X6Jd7jB484BFBsFF+AT6nNP
         knlKmMJIeISIkNPLn3LgBzuvT5VzobIGNH/TZ5967L7e+8QGhHIR7PKFCp5t++ieu1zM
         /nIUvMXny7q4tgSCPh1ORNNhmSJlB9uDqemIP7Wjh6bDeZdIpC/OYbQuO/stI2Lcoun6
         NkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168429; x=1795773229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAfymCHccjaSnDwBzcAFu1I4f93kNUDtOAKH0uubUTk=;
        b=FrG/1/fiffzV6Raz1pAEKMWGjO3RMa/61MElCq2Y7kPDR/pOQBMjixuUZfNrEtYryd
         pK8HyxmYSbHj50GOZAcmS9X6kJj4qWMtIVSn9/U5/K49tpxVWN3saqM9wN3OaoFsKDYf
         lwc7KXUBbiYZuVv4SWo+4quxKT9GaPC3N9xjQ0lZAkzDAHh3ZjOkqE9+8uc2UFHVKL+T
         AipIAodwLYtGhIGb9S9obxgzl4w2IeGilx+PnWYN6rfN/+sZOXVfuNXiCha3BesbVKvy
         Ahduy6GoThv6PJ5dRgoFGxIIex80Co7s91Pho8uWBokn4ZhJ617/UwLm5406oapKMV0+
         zMzg==
X-Forwarded-Encrypted: i=1; AL+hErHnXFODgutv+gNB8sQnaO8cXZJf5mnCCnI32qX3nv3Rdi8JRdCt3siOulZqoynlgCXwtgv87Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+HiCD8qprLyPkB/WVZEZ5OWkzDmZ2hx2bE5LMMJgduNQoMrMse
	zEpwth1vIUhEoz3so6F13z9iLpHKparnfR2XmUEyheLCOXn3SB2ZAJNzCkawGVJCGbhf3TgLs78
	ragab1GGq390jEEIu+VMpp7DmSn1gLWs=
X-Gm-Gg: AYBFou0GFnAaYWfaQB6duO9vKSlEEepefZvoVkDXZ7K+XiA79ZhgEYk1W4wKRmBDD/W
	8cxNy8Qsxgc6tCVnHLPa2KO4iRAQxbrMJsoflumBJ8HGu5P06GSC4kNz8B2J7Jvn3L51v3fT5Rb
	dsV3DTI+7n0jSRYscAbnhHxU7ja9BfVAXtAHd0eO2KxpPT/Zg1pTCZINILX3q405Qbx1E2puB2t
	YKjHf8e7HmmXe2Dm2vpkFXzPgP8MKTJj/Zqc1xnOokCA2prG3oP50rLW17MYr0Jxl300c509Y4y
	/KVH3qBnfMURN7ZeESpUESFdZY3YxBJ56mY/5A04G2xU6LvN6U0Yl6QFOanMToIkIphD51Djh8r
	rbE4iEgoPmaqSjOLtj9r1i2eAFtq/SwvzZJoY3tWeVJLAVgi1eHktx3ohtWwNk5St
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb88817d91mr55598215e9.23.1795168428776; Fri, 20 Nov 2026
 01:53:48 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-17-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-17-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 17:53:36 +0800
X-Gm-Features: Aa3M54qdUFU2sI5bnRLRApKXsgxmqqGXoOIYcRvpBXntBh5ayMnUgKn48bYdX08
Message-ID: <CAN_Opa9APLNic4cnohrtZ4-HcdoNvSFvnAKiC6nn+C=thbTAAA@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] mm/mglru: make folio_test_workingset() work
 based on folio LRU refs
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> folio_test_workingset() currently tests the PG_workingset bit, which
> is only the second lowest access bit of the folio LRU refs count now.
> Folios with refs 4 or 5 carry it in the LRU_REFS_MASK field
> and no longer have PG_workingset set, so the bit test misses them.
>
> folio_set_workingset() currently sets the PG_workingset bit with a
> plain set_bit(), which also over-promotes folios at a higher refs
> count: e.g. a folio at refs 4 is bumped to refs 6, advancing it
> toward LRU_REFS_MAX and an earlier generation promotion.
>
> Move the test into mm_inline.h as an inline helper based on
> folio_lru_refs(), checking refs >=3D LRU_REFS_WORKINGSET.  The set
> stays a plain PG_workingset bit operation reserved for the
> classical LRU: under MGLRU the refs count is maintained by
> folio_inc_lru_refs(), and now triggers a debug WARN when called
> while MGLRU is fully on (the switching window is exempt, as the
> classical paths legitimately run alongside MGLRU then).  The one
> PageWorkingset() user in erofs is converted to the folio helper.
>
> Under the classical LRU the refs count is not maintained, so the
> test is equivalent to the PG_workingset bit test, which is the old
> behavior.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  fs/btrfs/compression.c     |  1 +
>  fs/erofs/zdata.c           |  3 ++-
>  include/linux/mm_inline.h  | 29 +++++++++++++++++++++++++++++
>  include/linux/page-flags.h |  2 --
>  mm/filemap.c               |  1 +
>  mm/page_io.c               |  1 +
>  6 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index ad90e14032db..127c5ee38979 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -8,6 +8,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
> +#include <linux/mm_inline.h>
>  #include <linux/folio_batch.h>
>  #include <linux/highmem.h>
>  #include <linux/kthread.h>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index e981e371d6c2..34ee41e1ccdc 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -6,6 +6,7 @@
>   */
>  #include "compress.h"
>  #include <linux/psi.h>
> +#include <linux/mm_inline.h>
>  #include <linux/cpuhotplug.h>
>  #include <trace/events/erofs.h>
>
> @@ -1713,7 +1714,7 @@ static void z_erofs_submit_queue(struct z_erofs_fro=
ntend *f,
>                                 DBG_BUGON(bvec.bv_len < sb->s_blocksize);
>                         }
>
> -                       if (unlikely(PageWorkingset(bvec.bv_page)) &&
> +                       if (unlikely(folio_test_workingset(page_folio(bve=
c.bv_page))) &&
>                             !memstall) {
>                                 psi_memstall_enter(&pflags);
>                                 memstall =3D 1;
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 2c6cbd0df686..a2442e49aca2 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -300,6 +300,23 @@ static inline void folio_migrate_lru_refs(struct fol=
io *new, const struct folio
>         __folio_set_lru_refs(new, folio_lru_refs(old));
>  }
>
> +/**
> + * folio_test_workingset - Test if a folio is in the workingset.
> + * @folio: the folio
> + *
> + * A folio is workingset when its LRU refs count reaches
> + * LRU_REFS_WORKINGSET. Under the classical LRU flag encoding,
> + * this is just testing the PG_workingset bit.
> + * NOTE: folio_set_workingset() must not be used under MGLRU, as the
> + * folio refs are tracked by folio_inc_lru_refs() with rules.
> + *
> + * Return: true if the folio is workingset.
> + */
> +static __always_inline bool folio_test_workingset(const struct folio *fo=
lio)
> +{
> +       return lru_refs_is_workingset(folio_lru_refs(folio));
> +}
> +
>  #ifdef CONFIG_LRU_GEN
>  static inline bool lru_refs_is_active(unsigned int refs)
>  {
> @@ -551,6 +568,18 @@ static inline void folio_clear_lru_refs(struct folio=
 *folio)
>                 folio_clear_referenced(folio);
>  }
>
> +/*
> + * For the classical LRU only: with MGLRU the PG_workingset bit is
> + * part of the folio refs count maintained by folio_inc_lru_refs(),
> + * and a raw set would corrupt it.  The switching window is exempt
> + * because the classical paths legitimately run alongside MGLRU then.
> + */
> +static __always_inline void folio_set_workingset(struct folio *folio)
> +{
> +       VM_WARN_ON_ONCE(lru_gen_enabled() && !lru_gen_switching());

Could shrink_active_list() still hit this WARN after the switch
to MGLRU completes? It can reschedule after isolating folios and
reach this setter after lru_switch is cleared.

Thanks,
Kunwu

> +       set_bit(PG_workingset, folio_flags(folio, FOLIO_HEAD_PAGE));
> +}
> +
>  static __always_inline
>  void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
>  {
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b0ddc652e76c..f6625dc042da 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -549,8 +549,6 @@ PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru,=
 PF_HEAD)
>  FOLIO_FLAG(active, FOLIO_HEAD_PAGE)
>         __FOLIO_CLEAR_FLAG(active, FOLIO_HEAD_PAGE)
>         FOLIO_TEST_CLEAR_FLAG(active, FOLIO_HEAD_PAGE)
> -PAGEFLAG(Workingset, workingset, PF_HEAD)
> -       TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
>  PAGEFLAG(Checked, checked, PF_NO_COMPOUND)        /* Used by some filesy=
stems */
>
>  /* Xen */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 648f783454c3..2939647940c1 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -21,6 +21,7 @@
>  #include <linux/gfp.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
> +#include <linux/mm_inline.h>
>  #include <linux/leafops.h>
>  #include <linux/syscalls.h>
>  #include <linux/mman.h>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a57cdcf2892d..12deab296718 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -16,6 +16,7 @@
>  #include <linux/gfp.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> +#include <linux/mm_inline.h>
>  #include <linux/bio.h>
>  #include <linux/swapops.h>
>  #include <linux/writeback.h>
>
> --
> 2.56.1
>
>
