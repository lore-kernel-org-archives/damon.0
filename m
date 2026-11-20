Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173412;
	b=E0zx0IH+VIrEvt0N/WMgkYTbvGp+e1sOt8AwsZx7Mkh04VQ+FXLsihkLN6fAWKc5VnwB
	 EJBTUb+28vFxzS4gbW3/ndQXZBxXCELVaG3nh7DoLR09pRe/C3GOiuf+q/jHVUeiyF81A
	 DxdH5NbrwbuWc4cf4vXEO5vszs4uY4gEkb5v5tqEHroZRkfDzkLbHfqPIp0gh1109UhIb
	 zmFiPrd7sPysM9PERRhdD7txSSf5UAL7mp7OaUU0h5sIIy+/U5e7CLPfm6rPakLKPcv+j
	 jy9rNvzpO9D7cD0ELjlmuyo5ohrHvZlKHsv8vKpH5kO0HVBjv1D4c/bv3UUiHo/RKsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0NaMGQ4Owpl3Co7yhqKVZHVr+kTFNUk1Lb3ecw2usVA=;
	b=m2GSCjhT+OLyR/uYf5YCN4L6HON4AQ3hX2Gr1410etY4Dzc0ak1ox5Bax28Vf6awhdE3
	 92YqufrWtaZPanbNSOJ9eLZCUF3iJRVl/N2X6vbpWx7abr1dgsm1vwamiO5Z8UxIv5ShK
	 PgmdvEUFhUjanyJb4KQ/ivr3Pv7r1oHN8jOeESjDONXgDJ2ULy1UqgLB0yUwMT1eH1kMV
	 j1RhDmeOetL0J8Wpz8NWPZxLmGbK/0CevYaKLZ88XQzXviLrD8EHjHIKhry4KDylGHqrt
	 nyUL5fDTgL+7mkS69g5bY+ENRUDXxstOoeetG1OwFfU12e4OdGJPsTOVo/MljmidSpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XXECee3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60D606A331
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 11:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F60D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XXECee3W
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50cc8e0f84so127005966b.1
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 03:16:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173410; cv=none;
        d=google.com; s=arc-20260327;
        b=JU8kzGlurJiioCwkJfT6YO/9t1O7bmhmHjDs/OntVjRq2LlYZQ+B407VsnI7Z2aVAd
         tlj0R+B+aO4i5MSenQyXJGamqK1zhZfQRty0NwXshk9vQO+uM6f4WbzT9fBqEDfBKlo/
         AqJKYt8bwFaVPFdpjAZFHCbsxQuQOUqNeAej7YUctZBC3hhhfoWwZIHayeRJ2UHh0KUe
         hV6aRhFzzJPPEZYSoKP8ubKYo5wsevAZuIy2u2+9ybglXSNOX/FQPcp7HxA6NDICsboa
         wN7HiCyyyDRXX3PohA6Zuv/dLawZnFNRN5MWARkq/T2A8lO6iZ2hx39ybFeSJY8WrY+k
         rxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0NaMGQ4Owpl3Co7yhqKVZHVr+kTFNUk1Lb3ecw2usVA=;
        fh=3DTaVk7mO/69qDisAJWscCh/+WXCkB4BOXozuYioseM=;
        b=TsRq0UIGc4TdBhqAfKONKUoVBtPgvL5O/w9XYJIbcrq2tfl3H20h3434GmGYwnGx7M
         U6q9LFSfxWlViVpmVelA8wuRJxUyNokwB4ZEvSFa0VM+ZHFr3C/raJ5qlsjqfcYetuvN
         UILbH/f+fxit5MwinUpbsVsJhaREe5tNCAZk0+aOpsPIuwQbpaUfKjChyO0o7dni9Pzm
         3crvWSznqIqBt41nHbr+uUdNSdYNfAKflcTyYIARIMGgVT4MNiU2pqvkNQeNn0UW3yoL
         nustftuJgkrD0xAqqTN/ENBR7dqvACdYL3B2zotfWifzXi/uy9xRAFpvXwquFa1zMwIR
         +lCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795173410; x=1795778210; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0NaMGQ4Owpl3Co7yhqKVZHVr+kTFNUk1Lb3ecw2usVA=;
        b=XXECee3Wk7RttiBjEmWxJU1sSztT7JsVLUa0kRKKLCZx5YAlBQUs8PIMeni7v91btx
         C0dGCkUvkshe5WuMWHVtyqexcyZjLWeHnT/NMiJwwbbrsrWsSsSTHAFyubTeoDhPKAIA
         Mby6uaCvLCtMB9jVi47Ahjzk3DqNu3sdrVcP4sqbtNRfrwTFj3N5hajuQ1azET4G2kMk
         ebsMUib1N5yDIJXr3qyIyePHxHUOkWMxV8SQN75ZEyjcrUBHihVxt/A2y2YX/67S8wIo
         qOzR3LBi0XV6f+Y0i/fHbjxQ+ob02DZ9Jpf6C+sAvZiUUL5NDrkTHewdkLrCLM0jnN8Z
         p1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173410; x=1795778210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0NaMGQ4Owpl3Co7yhqKVZHVr+kTFNUk1Lb3ecw2usVA=;
        b=o8f5NgjOsBd6m4qu2+xGCkARTk8jZZSecK0ucVWrK59RfYfDEcujxxMbWh2rhT35Hd
         dW4LZTBetuSjq7L9LNv7SrEaa2UmztSvw0lV1WJSIg0qsxp/REMAdO+Kiu5Myn960LPS
         urzSfHaauSzXHVFTgqJWJ0LwJWWP+gFTV7AnWwqr/svzp7pztP//LuVb8S7v1Y7BDi7e
         rJANYDspzIv4PIx1gf9qwluBgt7Dgcsy7otMXcbq9DPXLWxxNuUA59JokRA+/zTgvXEw
         oeDchUX56ndmDDmVXIJMh+tHRIwQRB5Sr8wfcYX1YMoszT981sUUPxjbUKQ9Nuhl/tPo
         vyow==
X-Forwarded-Encrypted: i=1; AL+hErFGz/sbaDvMEghaYQmCSFqzLwLkSFFZtx6scTFQwEeBWKs+3ZOoYU4X0JgPGqZYoRozslrUhw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/30blBOfVQNL6kCMAsgBCWavvn8zqiAJVSY0p612bSpKDceiZk
	VTbAqt7Ws6rV+T6/zwvJXohpYNFQ51rGOskQpm/KJsK9kH4YRfztCU1e9tqu0aJi/KW7JHjNfkQ
	OekDsiLW8MDgZeq9UPSMdhnskNPZGeJU=
X-Gm-Gg: AYBFou1Kn1difV3ua+yL+NeXze7LTPzDF8kloBmLcEhegSrG1JcFVMuWWZUX4ZsHzFC
	/kNg/fOQg6AHMvm3MBu3Fxg/2Ghp/qd6kKKexYuoInhx0hh48d42IKMEc95pR5To7QWei76YeyA
	hkzvJLLtBDjKIjkgRyoFMK3LGxAX79Lbo8z0hZC/rc6Ethp2LnI/L30ZAccjiEU6zbG7kPb91sq
	Rbs0S8HI1ngoy1oOgbPwUzXRYpIdIux/xknUdpc0YgHDWefo4/KlazYoO9Ahn4vudJd6yIHBIoe
	sbf7F89bTNSd2hv/AIdhwyKGxL+UZAoGV+BSrT25LoyOSEXnU0AdHZQ5slgniYD+JEnyjFN4NhZ
	iJriUJSCM21Le62C76aCFzOgk7kf5TL6d+cwK03KhrGajSnWCQPlTA+6lhjhjUbbCI4NWFw==
X-Received: by 2002:a17:907:73cd:b0:c40:38b5:d784 with SMTP id
 a640c23a62f3a-c513a614467mr280155766b.22.1795173409664; Fri, 20 Nov 2026
 03:16:49 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119154001.9b9f953136935a09e8a50af6@linux-foundation.org>
In-Reply-To: <20261119154001.9b9f953136935a09e8a50af6@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 20 Nov 2026 19:16:12 +0800
X-Gm-Features: Aa3M54pc2xETNqoexA8P5jVd0jSnzthhaZdG2Uuuwphbutgg3FiGQAMnp8Ovueo
Message-ID: <CAMgjq7Dd=Y+GekSD9WO5oGdoa+S1eG3T-U=VsCexopvb723zFA@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
 and flag cleanup
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
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
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 7:40=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 19 Nov 2026 05:03:32 +0800 Kairui Song <kasong@tencent.com> wrote=
:
>
> > This series implements MGLRU-FG following the idea proposed at LSF/MM/B=
PF
> > this year [1], based on current mm-new. Depending on the workload, it
> > improves the performance or reduces IO by roughly 10% to over 50%,
> > fixes multiple long-standing issues with MGLRU metrics, and drops one
> > page flag.
>
> This is looking really good - great stuff.
>
> Review is thin, so I'll remain in wait-and-see mode for now.  What do
> people think?
>
> I told LLM to put this series through its paces.  The performance gains
> were confirmed (actually muchly exceeded) and it couldn't find a way to
> break anything.  It found a smallish slowdown in writes to clear_refs,
> which doesn't seem very important?

Thanks! Glad to see another positive report. And yeah I think
everything is fine.

The reply below is a bit long (and 99% not LLM generated :-), so
TLDR: We fixed a long standing "bug" here in with a small (IMO)
interface performance drop, and that interface's user was already broken
(which we fixed), and I think the performance can be easily recovered too.

("bug": it's just messed up metrics readings, there is no leak or
race, just these values are just no longer meaningful in anyway and
are breaking real world usage, see appendix)

A slightly (~10% end to end, that one interface only) clear_refs
writer slow down is expected, smap is the only user for that (maybe
DAMON too but it works differently and won't cause this many calls).
However, the thing is smap reading was almost broken for MGLRU in
mainline, just like K8s users have to disable MGLRU by default for
years because it keeps giving gibberish readings (See Link [20],  the
refs and workingset are tangled in PID controller / aging in a
hard-to-describe way so we see seeing unrealistic values).

This series fixed that, metric readings are now sane, stable and
accurate, close to CLRU and provide useful data for workingset
estimation, so the trivial slowdown of a lessly used interface seems
very reasonable, and we only slow down the even colder hard reset
part, readers are good as before. (We'll also need to update the tools
ABI part later, but that's too long for now, and I think we can live
with it for a little longer considering it has been broken for so long
time...)

Meanwhile, if we want better smap reset performance (I'm not sure if
we really need that, since it is costly by itself already, a whole VMA
locked walk & PTE update per page, and ruins the hotness info), we can
do this:

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index a2442e49aca2..45808f7ae50c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -562,10 +562,12 @@ static inline bool folio_check_lru_refs(const
struct folio *folio)
  */
 static inline void folio_clear_lru_refs(struct folio *folio)
 {
-       if (lru_gen_enabled())
-               folio_reset_lru_refs(folio);
-       else
+       if (lru_gen_enabled()) {
+               if (folio_lru_refs(folio))
+                       folio_reset_lru_refs(folio);
+       } else {
                folio_clear_referenced(folio);
+       }
 }

It should speed it up instead for most cases, I didn't include it just
to keep the code a little bit simpler. Smap and DAMON are the only two
users, so it's safe to squash this into Patch 10 "convert to LRU refs
based operations for MGLRU" directly.

In fact, if we really care about smap performance we should start
batching it instead of doing things page by page like right now, I
think that may bring a much larger speed up.

And a Appendix: Measuring the smap Referenced, and active / inactive
reading during a build test (LLM did help on this :-D ):

      =E2=94=82 smaps Referenced/Rss % min/med/max =E2=94=82 span =E2=94=82=
 stdev
CLRU  =E2=94=82  99.4 / 100.0 / 100.0              =E2=94=82  0.6 =E2=94=82=
  0.0
MGLRU =E2=94=82  38.0 /  99.6 / 100.0              =E2=94=82 62.0 =E2=94=82=
 12.3 - erratic and unstable
FG    =E2=94=82  99.9 / 100.0 / 100.0              =E2=94=82  0.1 =E2=94=82=
  0.0 - matches CLRU

      =E2=94=82 active_anon % min/med/max =E2=94=82 span =E2=94=82 stdev
CLRU  =E2=94=82   0.0 /   1.1 /  24.9     =E2=94=82 24.8 =E2=94=82  4.5
MGLRU =E2=94=82   3.7 /  96.4 / 100.0     =E2=94=82 96.3 =E2=94=82 23.7 * c=
haotic, almost random
FG    =E2=94=82   0.0 /   0.9 /  12.3     =E2=94=82 12.2 =E2=94=82  1.9 - m=
atches CLRU

      =E2=94=82 active_file % min/med/max =E2=94=82 span =E2=94=82 stdev
CLRU  =E2=94=82  34.1 / 43.8 / 52.2      =E2=94=82 18.1 =E2=94=82  4.7
MGLRU =E2=94=82   0.0 /  0.1 /  0.1      =E2=94=82  0.1 =E2=94=82  0.0 * en=
tirely wrong, always ~0
FG    =E2=94=82  24.3 / 33.5 / 42.2      =E2=94=82 18.0 =E2=94=82  5.7 - ma=
tches CLRU

Pool over 3 test run with make -j48, defconfig, ZRAM as swap, 3G memory.

It can be seen clearly that the metrics readings before FG were almost
gibberish, FG fixed that just fine. These are causing issues that
describe in the Link [20] above, and many other components. And they
don't write to clear_refs, they just read meminfo, smap is also
included here but less used.

The active anon reading for both CLRU and FG seems a bit low, mostly
because this task is under heavy pressure and aging/reclaming fast,
and FG also provides the way to tweak it in the future
(LRU_REFS_ACTIVE). And FG reporting a bit lower is somewhat reasonable
since it does reclaim better.

Note, the goal here is not to match CLRU, but CLRU was clearly doing
much better on this, so using that as an reference shows the
reworked readings are indeed normal and reliable.
