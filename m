Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529255;
	b=5JN6zwq6NTGgx1edPForBkAMy0Hk/WmzJIfVSocsijZ56DvYXnWagoj4VUUXa8I85r3z
	 gvwUoQUT/lmNWWj44n+CDopP8jafc+tcTHnxhV86geIaTvGFBxaO9EVR8sRMDgycjvfg8
	 hMpSDcHX5emy0EeSSLVrsTGKEYgw5ICKYd42n5GZsl4FNa+QCOKL8K/in9ZN0KARvj4ZK
	 ne6YLApXlB1JMVpG3MGFOhBMGi5jEv+RUUd6q2mxBLg/f+o4XSfcmqcFm8LjwK75ZD7pT
	 vyu7AvKulCMbm+ymW+EeHNn14Riy53H5HJ9isgb105mxKOTuILetwaApUqDJf4MDCFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529255;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xQwGSvzYOohT9kUoKDV9cqE99QB5OZ5zFZdvCKpT658=;
	b=EglzV0J8uzZNTji7rzblTUV1GMRKuDPzEeWrwXHEq7Uy9aXZNxgN4LWPmQXaDdyKD37r
	 hIwMOnQ4P1MD8CNnD2mM1BhBVGye2rJ5r4LzZ3lxDdWHUthvmhm4g2hOZISL2h3FjwfmM
	 BtTEzyeVZ6uJxsLdtuveC6NmH5y0nzYirHxayKdLZOBhHeuGxEXnCAX2z3kNZBNUnnm6y
	 P8VGgIoT5PhtzauJOJnfDCFFzwiBF8n4vD3KD4l6/9C/n70c5aXi1BrTXlDpOM4Xo02MI
	 cFxXjuPfHsPTg2hOjLqo0oD3tUdskqdj2BWA7ZbAr+TTEOr3dV9HmOioD/QSMZSC98A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5o3lkKZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A8606A328
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5o3lkKZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7C41F000CD
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529255;
	bh=xQwGSvzYOohT9kUoKDV9cqE99QB5OZ5zFZdvCKpT658=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H5o3lkKZtcjIhxg1Jgv4YSB4NydIvtuc83psyEK5vHeRwE5AllHqOE+kagT49yEZe
	 zwV71Bqz3Fbr0bOUAQrGu+BejHU33ufiDBEFwR7lEyUo+r+6IlnvxT6EHL5YegDHsP
	 W6Xl4C2XARRVmAJ8dlVmPzEL5+kTLphtPUPtxZrVrGcSEEuvZh5EVGcRSQ0kZkWTTE
	 tAbvtvgmiHXSwfGCFrH2dV9vL+iwUIGZcatOfzrqr5sJHdvW1pnewqB0paRiHoU0eT
	 KEycgEnnFkMimB8kxFQrVRjdJfGFpDVHp+YfD2lb/9y+m2K62825e2pUfFr/sRu60/
	 RATdnq8u2bQYw==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5364c951da4so899651cf.1
        for <damon@lists.linux.dev>; Tue, 20 Oct 2026 13:47:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz7bajPa8ndYXe65C+mD3lyTET9x8352ctUXcTUuP/qLdHsi+vwrDw0mDtD2XMLtmg4c8qfbg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLjtWtbhyGKbcbWasVtuSaQTXmFoVvpgtJ2WKU3/wFP0Rz4V+Ur
	g0HqD3UTE6EhPEdmrJAMfHMZDntJdDx2fjlqjx/sRlVR/w5CVxTGeokjM4T9EvN+26N+UD/kaix
	8zkzg09TSAPHynO2+mTvNAUHwrcgxM4s=
X-Received: by 2002:a05:620a:171e:b0:93e:c12c:9dd2 with SMTP id
 af79cd13be357-93f57f7a370mr81878885a.82.1792529254015; Tue, 20 Oct 2026
 13:47:34 -0700 (PDT)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016084256.12955-1-baohua@kernel.org> <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
In-Reply-To: <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 21 Oct 2026 04:47:21 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yfX-__y0f5_od7r+j=Hqz2YAGzFDRyVP4s-6t8dh0_rA@mail.gmail.com>
X-Gm-Features: AclHuK_6OQJo2WkKc2jeoR4HdJ1oLezMrDS6BoCD9oiiIL1tyFrKMHixg8usnik
Message-ID: <CAGsJ_4yfX-__y0f5_od7r+j=Hqz2YAGzFDRyVP4s-6t8dh0_rA@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
 and flag cleanup
To: Kairui Song <ryncsn@gmail.com>
Cc: devnull+kasong.tencent.com@kernel.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, 
	cgroups@vger.kernel.org, chenridong@xiaomi.com, chrisl@kernel.org, 
	damon@lists.linux.dev, david@kernel.org, dev.jain@arm.com, 
	ehab.ababneh@intel.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, kunwu.chan@gmail.com, lance.yang@linux.dev, 
	liam@infradead.org, lianux.mm@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liuxiang.277@bytedance.com, ljs@kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, nico.pache@linux.dev, 
	nphamcs@gmail.com, qi.zheng@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryan.roberts@arm.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, sj@kernel.org, surenb@google.com, 
	tz2294@columbia.edu, usama.arif@linux.dev, vbabka@kernel.org, 
	vernon2gm@gmail.com, wangzicheng@honor.com, weixugc@google.com, 
	willy@infradead.org, ying.huang@linux.alibaba.com, youngjun.park@lge.com, 
	yuanchu@google.com, yuzhao@google.com, zhaozhengzhuo@uniontech.com, 
	ziy@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 7:44=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Oct 16, 2026 at 4:43=E2=80=AFPM Barry Song (Xiaomi) <baohua@kerne=
l.org> wrote:
> >
> > On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay <devnu=
ll+kasong.tencent.com@kernel.org> wrote:
> > [...]
> This is a nice change, but meanwhile the LevelDB and cerain workload
> gain are gone too, we will again have a ~40% regression for similiar
> workloads, I just double checked it. But that's fine, though, it was
> never meant to be optimized that way, and the long-term fix can be
> done later.
>
> A quick test on another of my test machine using Tal's LevelDB test case:
>
> CLRU: 3098 ops/s
> MGLRU mainline: 3035 ops/s
> MGLRU-FG: 3233 ops/s
> MGLRU with this patch: 2194 ops/sec (should be same result with
> reverting 6cbdd9726fb5)

Sashiko is raising serious concerns about this approach, so I'm
really considering reverting the commit. The downside is that
the revert would also regress some workloads, such as kernel
builds and LevelDB Scan/Get.

Before we have to revert it, I'm wondering if the one-line
change below could fix the SQLite scan and lookup regressions:

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ab69b9930893..a3a894aae10b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -327,7 +327,7 @@ static inline unsigned long
lru_gen_folio_seq(const struct lruvec *lruvec,
                  (folio_test_dirty(folio) || folio_test_writeback(folio)))=
)
                gen =3D MIN_NR_GENS;
        else
-               gen =3D MAX_NR_GENS - (folio_test_workingset(folio) ||
folio_test_referenced(folio));
+               gen =3D MAX_NR_GENS - (folio_test_workingset(folio) ||
folio_lru_refs(folio) > 1);

        return max(READ_ONCE(lrugen->max_seq) - gen + 1,
READ_ONCE(lrugen->min_seq[type]));
 }

If it works, It should be entirely thanks to the inspiration from your MGLR=
U-FG.
