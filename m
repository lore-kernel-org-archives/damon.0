Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471B46D2DE
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152732; cv=pass; b=mCgcIzgC3D8lCK243bcTbfelQ5tezimWirPTKoR4Cme48Dt7eJl0kGUxQMV0qR7YIQqweBYsZR4Zc5COxYGxZsj1DHrEtTFTfRnoPhvYBFFjfRtkHU1CpY+ZsQagN3gX6FRAPiIpjOTzxQrUAH+tGQqeBQCG3ucP57rgSPAw2qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152732; c=relaxed/simple;
	bh=6IYjp02uYmxvMluUbWofrgoM9m03JSf8XQivc0rvedw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bapg1ZxBp7mF3z3FifwEBArdgHFKRM633mRRxnk1XsE1kVbuNL0CGhtnOUKTNaOdsOkkG0FssKQyIk8f6Vyiqr+e465JIOF670bqTf6nNXQ6tLLuJWwsWWWrWkvwriZWqD0xdikdA6gEnHIu3pyDIKiVyjwTsrz6LI2QeQn61hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBrLpWZW; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBrLpWZW"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa29e06bso5537773a12.2
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 05:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792152729; cv=none;
        d=google.com; s=arc-20260327;
        b=hokTrOuK3oLOg2WrJ4wpcE8Qo77WHgXhTJ+Sv+b3W41dmYEfDofvI34uAgfMsKapmB
         r4x/l/ncOsvcBuqWBzugI4dGXJbwnk0xaCNZBPdHusGFfOPEjo/5CHAxWRKZVj7R8Qif
         FblesqmXocI8i/4vIx8XarhiwJLHaVYIesQ1NXFoS87OtBh6xvAzC/1EJ3nrBhKAs85j
         cw61WEJCCdEjEmx/OrKab4FzfZkfMdPeQFahBbbhJw1zu6JnsFWm+FncYIMR+bph0iUH
         OCFNkZIAHhF5aiWXy8/c8D3Q/ij9IKh39csFR1LHoNVbZi3bPEu4EF/dEcJrFamGZ27k
         5Rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6t2J8EE3L3nlE7G0BZMfNQxPefv2h/6dn0nY1OvRibM=;
        fh=L1aBkrPn++vVn7TPs69pL2aDve9hJnj/o5dxuHtPisk=;
        b=Dw6I2q3QGviiygyikVNGJkxRdHR01SJNEIA9ztcswkTQa91sjxdXRJSMFOngPDt3sc
         nGvG1206e5vrYfWvtuPgdSkuAASmntZhzwbsAAraGVYZlWPMwAZRICP5a7s2GfW9pZY8
         dq7b7N70WYeX+leBM803ch0F+GDXvOMt6AqH/AMa8vaYSR5rBwGnZbsjx35MdAoZC3J2
         tKX8SPHsDt62/fiiDl5sj+iUcZoF0rKYpP+FvCqyADzCYv4DXdExr/AXHYjCCFk7oVU6
         CnohP64jOhBErH4aS+sgqyLX44zzF1+lIKQAesgAXtN3YcnMHrkVc/Q281CZ0kP2gI6B
         3gxQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792152729; x=1792757529; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6t2J8EE3L3nlE7G0BZMfNQxPefv2h/6dn0nY1OvRibM=;
        b=hBrLpWZWNBbu3SdWYyJrJdCsTwqRPMIGi2UfiLKjj4eVVn9SKrH6zeaMZNI3xKEX7N
         uilIXQF4oJwGAKzylGdoINmfVIfRgS6MqXwyAw+eL9t3aRZDaKqxUq4bYTWtMT5c4CGL
         BrEjRzr/o5Ww47oIS37UIXDA0g208xgG5Ag7/Ax+OuxbxzdkUSQG64jKO7MLmpWzFVqv
         ZqCh7GvBEvGIZTvZAaLrqD5cwT+cOCvRqVc2hBmr9pfryE6kpIK3IH2aXi3Pv+Jn7UXU
         zReOZSys/rfAGEsPARuv4c+ba1KHcidFr97WcgIXwN4CHHXPO2KR1CUVg5+OyuO98AVm
         8aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152729; x=1792757529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6t2J8EE3L3nlE7G0BZMfNQxPefv2h/6dn0nY1OvRibM=;
        b=V6DSkBIS13wvwTL/Au2Q6GlMxKHtpaaHl9eHfgNbHYqm4KJZCdzxoEn2m+3JfU7VNj
         /mtvhdM7kFe1+f0tbgyyo3RqIUzO5wIUQvjS/n7x47aAPSbILFAIRXA6LyzS47Twe7D/
         faXmwr8CYiB5IPLBfXhWUc3w1FGd5C/JC+S5xUUSQKrHRHYyNs+rNzQAGuPqH7ukoSFz
         r0ma4csUhgXZxOmgLmaIgif0apbrZs1PGqcWrCVj0J9ZlsOhdpdCUUmg9V8zI7WHi/DR
         K70GEfjzgHbrkwtgrWeYur0o4uMlfHmfksTlXhtsTixDDTSf+Xr3Y/kGClbVbbzzAQrv
         m3wA==
X-Forwarded-Encrypted: i=1; AKwUvBxOGlvgD8th8pZ3Vkn+Pb6sxoWlpFwsOQY/RPSamX62TNra2G1Nh4l9WF5lcARrnLUKGGLMtQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLA1Piq9PrzBkpwNqnodeSPqhguRMOvDnWFU6vafyrCRh/Kyxc/
	a9xQ+Ug3MfSzy35zeHvV976xgprE3duJO6cPib0f6nWhU8oF1sqG0jvhI0i9vsbBAz5wIxAG9e7
	hsqs4vvEZGCnHzfEI84tqSrQJH+DiVao=
X-Gm-Gg: AYBFou1rCnJ8cnfQpXJeSo1sEvBVKDGs/jReXy29h7hES8RSdgxttTYLmVMPXR587C2
	GMQg1Z7RqRTraTxI+sHt+qEPYvBlY1ezCgnKUoqRgH9JtDS9M7STnUJFAEq9/DtNU+am6n1gd/A
	tboqhInh5VzPfFi6mgiFXjmUmiKhvLyyc3wX3017F7oE9GO+YNf4YNxNuPmsZJW8lFaWWm/eur0
	vrpGTFOsl70PeFlo0DgfTQH6IyV03CTkXVQ4Q75cz2oHYnmrWcXWWXlY3UQrILEXVQ7Jtt210c2
	rorVOMOvzaMh27WQhrxLp3UmHIQMgcgmO16X3ZYAp9USty2ixl4cs78IUHBRPHvuAA0yiDu84bh
	JrsW5UeyoF3Xm
X-Received: by 2002:a17:906:ba90:b0:c41:1e13:4ba9 with SMTP id
 a640c23a62f3a-c411e1365e0mr83342566b.6.1792152728681; Fri, 16 Oct 2026
 05:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016084256.12955-1-baohua@kernel.org> <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
In-Reply-To: <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Oct 2026 20:11:32 +0800
X-Gm-Features: AclHuK-z6qzMGmKAbzLQtij7nv772LAigQWhuT7JqlQxVqOPHcB0PjAQdUtEGDA
Message-ID: <CAMgjq7Ao-1q5r7KtwV-UyvuP3hSazkfr3BbmKL+fv=dSDaU2Cg@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
 and flag cleanup
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
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

On Fri, Oct 16, 2026 at 7:43=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Oct 16, 2026 at 4:43=E2=80=AFPM Barry Song (Xiaomi) <baohua@kerne=
l.org> wrote:
> >
> > On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay <devnu=
ll+kasong.tencent.com@kernel.org> wrote:
> > [...]
> > >
> > > LevelDB Scan/Get
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > I also retested the LevelDB benchmark from the cache_ext paper [5].
> > > Interestingly, mainline MGLRU already beats CLRU on this one after a
> > > recent change in lru_gen_folio_seq that bumps new folios with refs =
=3D=3D 1
> > > to the second-oldest generation as discussed. That change accidentall=
y
> > > gave random reads a higher hotness level while making sequential read=
s
> > > much colder as described before [14]. However it's unreliable and
> > > incorrect because it depends on LRU drain timing, and hurts some work=
loads
> > > as reported, or where the sequential part is actually hotter (any wor=
kload
> > > involving hotter large file and many small cold files will be affecte=
d)
> > > which is reproduced below.
> > >
> > > This series improves it while covering ordinary workloads too and sho=
uld
> > > fix regressions:
> > >
> > > LevelDB Scan / Get, Throughput Total:
> > > CLRU:         4708.3 ops/s
> > > MGLRU:        5026.9 ops/s (faster than CLRU, but hurts other workloa=
ds)
> > > MGLRU After:  5179.2 ops/s (even better in all cases, and no regressi=
on)
> > >
> > > The hot-sequential and cold-random workload can be easily reproduced =
with
> > > SQLite and grep. SQLite continuously scans and looks up a small hot
> > > portion of a DB file, while grep iterates over a set of small files m=
uch
> > > larger than RAM [6]:
> > >
> > >          SQLite scan & lookup time:       Grep iterate time:
> > > CLRU:                       14.51ms               13281.37ms
> > > MGLRU mainline:            567.05ms               13694.47ms
> > > MGLRU After this series:    10.58ms               12930.43ms
> > >
> >
> > Thanks, Kairui. I'll do a thorough review of the whole patchset over
> > the next two weeks.
> >
> > BTW, do you think we need a quick fix patch like the one below
> > for the above problem before this patchset, so that it can be
> > backported to stable? I assume your patchset is too large to
> > backport?
>
> Hi Barry,
>
> Good question, I think we can patch it first.
>
> > From f9683205d2ab6e3b185022d7d5af3496dfe5f35f Mon Sep 17 00:00:00 2001
> > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> > Date: Fri, 16 Oct 2026 11:48:06 +0800
> > Subject: [PATCH] mm/mglru: fix using folio_mark_accessed to replace
> >  folio_set_active
> >
> > Commit 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to
> > replace folio_set_active") tried to avoid over-protecting
> > fault-around read-ahead file folios by placing them in the
> > second-oldest generation instead of the youngest generations.
> >
> > However, it abuses `PG_referenced` on read-ahead file folios
> > for this purpose, potentially coupling their handling with
> > normal syscall-based file accesses that also use
> > `PG_referenced`.
> >
> > This could regress some workloads, as reported by Kairui Song[1]
> > and Ehab Ababneh[2]. Many thanks to both for reporting these
> > issues!
> >
> > The long-term fix is Kairui's MGLRU-FG, but in the meantime,
> > we also need a quick fix that can be backported to stable.
> >
> > This patch reverts all of the original commit's behavior that
> > abuses `PG_referenced`, while preserving the semantics of
> > avoiding over-protection of fault-around read-ahead file
> > folios by adjusting only `lru_gen_folio_seq()`.
> > Specifically, fault-around read-ahead file folios with
> > `PG_active` set but `PG_workingset` clear are placed in the
> > second-oldest generation.
> > Activated file folios and refaulted workingset file folios
> > are still placed in the youngest generations.
> >
> > Build kernel cases in a memcg shows it not only perserve
> > the benefit of original patch, but also even improve
> > performance further.
> >
> > w/o fix:
> >
> > real    1m49.094s
> > user    25m31.484s
> > sys     3m40.959s
> > pswpin: 662112
> > pswpout: 2504415
> > pgpgin: 4424336
> > pgpgout: 10355273
> > refault_file: 359626
> > refault_anon: 670724
> >
> > w/ fix:
> >
> > real    1m48.913s
> > user    25m31.639s
> > sys     3m30.875s
> > pswpin: 689815
> > pswpout: 2689894
> > pgpgin: 4422659
> > pgpgout: 11043464
> > refault_file: 326566
> > refault_anon: 697138
> >
> > Revert original patch:
> >
> > real    1m50.044s
> > user    25m37.137s
> > sys     4m4.493s
> > pswpin: 1349087
> > pswpout: 4317933
> > pgpgin: 7083597
> > pgpgout: 17602735
> > refault_file: 337676
> > refault_anon: 1368542
> >
> > [1] https://lore.kernel.org/linux-mm/20261003-mglru-fg-v3-0-cbd4546a5bd=
9@tencent.com/
> > [2] https://lore.kernel.org/linux-mm/20260901180704.168106-1-ehab.ababn=
eh@intel.com/
> > Fixes: 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to replace foli=
o_set_active")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > ---
> >  include/linux/mm_inline.h |  8 +++++---
> >  mm/folio.c                | 16 +++-------------
> >  mm/vmscan.c               |  9 ++-------
> >  mm/workingset.c           | 10 ++++------
> >  4 files changed, 14 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index ab69b9930893..7aaff4e06e80 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -311,7 +311,8 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
> >          * | Accessed through page tables and  | Accessed through file =
descriptors |
> >          * | promoted by folio_update_gen()    | and protected by folio=
_inc_gen()  |
> >          * +-----------------------------------+-----------------------=
------------+
> > -        * | PG_active (set while isolated)    |                       =
            |
> > +        * | PG_active (set while isolated)    | PG_active (files|     =
            |
> > +        * |                                   | fault-readahead)|     =
            |
>
> This comment is not correct I think, faulting file folios are not
> access through fd, we may just better leave it uncommented.
>
> >          * +-----------------+-----------------+-----------------+-----=
------------+
> >          * |  PG_workingset  |  PG_referenced  |  PG_workingset  |  LRU=
_REFS_FLAGS |
> >          * +-----------------------------------+-----------------------=
------------+
> > @@ -319,7 +320,8 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
> >          * |<---------------------------- MAX_NR_GENS -----------------=
----------->|
> >          */
> >         if (folio_test_active(folio))
> > -               gen =3D MIN_NR_GENS - folio_test_workingset(folio);
> > +               gen =3D MIN_NR_GENS - folio_test_workingset(folio) +
> > +                     (type ? !folio_test_workingset(folio) : 0);
>
> This looks a bit hard to follow. Does it mean that for active but
> non-workingset files, they are put into the third newest generation?
> It creates more divergence of file / anon but if it work for now, I'm
> fine with it.
>
> >         else if (reclaiming)
> >                 gen =3D MAX_NR_GENS;
> >         else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(fo=
lio)) ||
> > @@ -327,7 +329,7 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
> >                   (folio_test_dirty(folio) || folio_test_writeback(foli=
o))))
> >                 gen =3D MIN_NR_GENS;
> >         else
> > -               gen =3D MAX_NR_GENS - (folio_test_workingset(folio) || =
folio_test_referenced(folio));
> > +               gen =3D MAX_NR_GENS - folio_test_workingset(folio);
>
> This is a nice change, but meanwhile the LevelDB and cerain workload
> gain are gone too, we will again have a ~40% regression for similiar
> workloads, I just double checked it. But that's fine, though, it was
> never meant to be optimized that way, and the long-term fix can be
> done later.

Here I mean the "optimization" of 6cbdd9726fb5 is more like a side
effect, and not reliable, that is simply not the goal of 6cbdd9726fb5.
So I think it stands well as a fixes for 6cbdd9726fb5.
