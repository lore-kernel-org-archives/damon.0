Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CB3955C6
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018789; cv=pass; b=gFYSsYzhsIKQW1+AEtEABktueO+9NM8w7DKbmvAsIJVTyTEuVoWgVOPsgTXOTiQneJdS9LwDvNYQFiEQDnCsLxJxH1t8BYKVq9oKTSccnno5DCZ0d9lgTp5zOQ/c9y6cJrZfjsssNk+2ST/Uf4AZy4Lc6wTwtYKlcDW8DJpv3b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018789; c=relaxed/simple;
	bh=pVEVvA6SvgT2Dh8mJqmOM7GLvNQfJPqq+oL68yZfE50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4/UotWPoBAyDjuSSCPC/6q3kUVv0+SMppxHdgTlsxgMREBgBQp5FrbBvLlU2mTnHWrhIHOMHiWWCo5wV76wZTGJKKAYeYb0v1EXBbWJ5mjVPd6HX7i7BBWujKefa/Zb73Ne83QdbT63i8JnhuvSc0hix7WvTNU4yx/2KCNjhfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SS0j7WHP; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SS0j7WHP"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765331535so2503311cf.1
        for <damon@lists.linux.dev>; Tue, 09 Jun 2026 08:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018787; cv=none;
        d=google.com; s=arc-20240605;
        b=ODY/cfPnGeChwZyEXe+sDtwQJSDvCP/xCfa0MWyFKB8Y7JyZQsxHdSkPsqM9A+g1vu
         If4uSaAKEEz2Krow+fmw9pQJOSJlymMhhV6fvxh397EP8B29iL56MOfszChQTZDOSbhx
         yjuQbY0gD73sMG30abv6PWZNF/KcQoy1QJ3/eQC68fg1wH8hNRUMCd6hGvnHTON2Te2D
         nqHYGC9cJmOhEPE6F+PAXFz2wtEQwy8WrEH6Mjwd1J2/SGtlBPuZ2Kd7S+aQsc8FUJzY
         RasgB3vWsn/TjuW2CVqlA/YKglMBFsJrRQ6kW1D2wG0h/g5OKrTLGEGGEnZqEUJpJCUt
         V6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rY2o/b8cd6ANaJfQdcKOucxVpV0MJrStEBR6w1nR460=;
        fh=cbmp/mgHBqDTA8C3gpzZTnuK+eXItDvEkwJ0zeOtir4=;
        b=KJKu2qzOn8LQFmoUeWCeo3K9hrmRUS4yDrBWJwUKGPYxoDCNXEq82coduii7G+baUD
         rcaS450/GAvE6e4pHkuZ/T2EtCvrnqa/tdHBUxD0eOjdGG7q1KTpJlNbuQtpfkCQf6qZ
         m/BUiAVv1nPzpDec9d8gnr9SxQkoT5PL6NIwKZINVcW170B0hx3HGb5mZGWmUtg4CGiw
         c+sYt9mA2ao2Ts9kgBLPbcP/28/TrcjglHLLYYyY/jBrlQuPmMIxytppZCG69GzKEdUI
         kVZ1BADwlWNtG2gt4XAvlA2tW1Q9PIbXEOXJwCw9RKAD1qhkxqNp+l765+iH/7qYRY0Q
         Faiw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781018787; x=1781623587; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY2o/b8cd6ANaJfQdcKOucxVpV0MJrStEBR6w1nR460=;
        b=SS0j7WHPotjBvs9bvGaDhFnFKPi5v4+WQRZ1WuQgHBHWArae2TsETqYP5yT5NckgmY
         0ZQD4Qfg3U+mPNY+w9aWhoGuHQf8Z5mHPwLPW2EmPxpP6nvlkXM0RT2Qba+eAKFVSGxe
         IUi+Ia2bxo8mVfQ/amLYs5cWuewjCLWLKnwr+aFXSthj9pNM3JNVomuBaFj9BgXLxyGR
         GJkHK3+zt5xvN/tkfStFl6FZHf+rDd+kBBDNfb0pQWkrC1hIOrChSAljn1RGP3WuW5OS
         qImksViHs7+QTnnTwswEIZOGdvsw9XEOKJ2mBvhEtVXswwr2UMyG8C1ZFUbK/PFOc1k8
         2Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018787; x=1781623587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rY2o/b8cd6ANaJfQdcKOucxVpV0MJrStEBR6w1nR460=;
        b=k+oxRzv6pvD7fQ2FuDnWFl/ldLMWR2KRMS3tUE+ba9QU/fa/uF7Nwgz00VSzEVT4+7
         83qlkANhwa/o3DuIByk4bk3Bx4sFahC+uKZUl1YfnaaMz3j0FeuLMiRih5IfmQ38HH18
         Mpyw5qgkrkFKC/exwdf3F17oOS5xU+c/RJMKxv/9saE4zfaPSjTn+u2uQ98e8grMwq36
         nuz65liKTCP51Kk/qwj0CkcNaQxvYkzNOnaCj8a4qX1BWvf6X7KnU1ImCgUyRE6h07Ow
         ZdJe0FsIveA7CzqAHp3YbJF/pkFgR4JzB1bFD9GDEaM+O0x3nVpQKL+qN9x47faiQMD7
         rpeg==
X-Forwarded-Encrypted: i=1; AFNElJ+vNg8pqi9m3OE7ZFzyv90WIp2U8LEgWEZByVyooIf/BZdNISGFV7+qw2R0pF8FOx66y3M7FQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRxw35abZ6n+HyuQZ6/ujAUyIhoTJIykyO0D/0QjmTs5p85xO2
	Vzuh81sI5EKXdvNXhPW6Ov5KIS6SxVjFZsIz9uisOIdt1R3NjGQ8bCMSZXqe6mYY9s83i63vzgw
	pzhdqPT/l3d+urWNm6YN3SYe/Q+xq04TDyP0xFiGD
X-Gm-Gg: Acq92OE4rtl/pPiGsWZu3L5P0hnsMT44TnwVgytCaG7fhN2l1PRClsboj31VLF7+QP7
	pcPGUyfEOgDM9aJt/y+drbzYPjsioe4iDtlXd4TRbIKQrHT04C6GqY3GTNJdXTv98JbUqfmoX50
	SIAu6Bw07GdowDb9KaP+ZNp0OAzfH863i+rWzrN7kBQT+WExl2B+7HFbgV5+fpNYgWiJAn+zfd3
	X9HAiFXQBwbGQjr7e5mJUYCjfk3UBq9mlKXr/+j8NRXvbOYdYqes41mwJ8io2taHHY87TQJZddi
	yIOyDeT0j0NgxNtgWtJAt2gGwZoL+/be23JeymYR1neUQ0cO
X-Received: by 2002:ac8:7fce:0:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-51797ffe81bmr33892121cf.5.1781018786362; Tue, 09 Jun 2026
 08:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
 <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com>
 <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com> <CAGsJ_4xTMsV8fJVfhshDQp4=Ax2f_+b6yR873cEP11bjcEa_5Q@mail.gmail.com>
 <3031859912bb43a7ab16ec63863914ab@honor.com>
In-Reply-To: <3031859912bb43a7ab16ec63863914ab@honor.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Jun 2026 08:26:14 -0700
X-Gm-Features: AVVi8Cd0phUCN63P78bsofAEIxBfBidiXphGPaa4I2_plf94aKBqa4-HMso_0rc
Message-ID: <CAJuCfpG6-PkWpRqr7m5evzTy9s8LyV3nW3TScOyjqWb+maVBkA@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: wangtao <tao.wangtao@honor.com>
Cc: Barry Song <21cnbao@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>, 
	"sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"liam@infradead.org" <liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:35=E2=80=AFAM wangtao <tao.wangtao@honor.com> wro=
te:
>
> > [...]
> > > > > I won't echo what has already been said in this thread (and I
> > > > > didn't manage to read all, unfortunately), but for such big and
> > > > > invasive work it's often best to get in touch with the community
> > > > > earlier. Otherwise, you might end up wasting your time.
> > > > >
> > > > > Ok, arguably, someone who writes that code learns a lot on the wa=
y.
> > > > > And if this code really was written by one developer only, I tip
> > > > > my hat! I'd be curious if that code already ran somewhere on some
> > > > > Android
> > > > kernel out there?
> > > >
> > > > I heard from Zicheng that they have been running this for months an=
d
> > > > it seems reasonably stable. Please correct me if I'm wrong, Zicheng
> > > > :-). This really should have been discussed with the community earl=
ier.
> > > >
> > > I initially developed and debugged this based on the Android GKI
> > > branch and did some preliminary testing on an Android phone.
> > >
> > > Since GKI generally only accepts features merged from the upstream
> > > community, and this memory saving could also benefit the community, I
> > > ported the patch to the Linux master branch.
> > >
> > > Because my English is not very good and I rarely participate in the
> > > community, I am not familiar with the community workflow. I did not
> > > send an email for discussion in advance with an RFC tag. I apologize =
again.
> > >
> >
> > No worries. I know someone who has worked on the Linux kernel for many,
> > many years and has excellent kernel expertise, yet has never submitted =
a
> > patch throughout his career for various reasons.
> >
> > I heard from Zicheng that you are HONOR's key MM expert and have been
> > guiding them on memory-management related work. That's really impressiv=
e.
> > Personally, I'd love to see more ideas and contributions from you in th=
e linux-
> > mm community.
> >
> > BTW, regarding my earlier suggestion about using GKI hooks=E2=80=94limi=
ting the
> > optimization to newly created VMAs and to applications that never call
> > fork()=E2=80=94do you have any ideas on what the smallest possible hook=
 change
> > would look like?
> Even if Android does not consider handling for 32-bit, KSM, or
> memory-failure, a large number of hooks are still required.
>
> A different implementation approach is also needed. For example, one
> or a set of anon_vma_locks could be used to mark whether a VMA is
> lazy, so that we can avoid modifying all places that dereference
> anon_vma. Reserved fields in vma could be used to record the root_vma
> and a reference count respectively.
>
> Roughly, hooks would be needed in the following places:
>
> 1. __vmf_anon_prepare: mark lazy_vma in the fault path.
> 2. __folio_set_anon and folio_move_anon_rmap: set mapping to lazy_vma.
> 3. rmap_walk_anon: handle rmap_walk for lazy_vma.
> 4. folio_get_anon_vma and put_anon_vma: add hooks to distinguish
>    lazy_vma handling.
> 5. anon_vma_fork: decide whether to upgrade pvma->anon_vma.
> 6. Add a hook in try_dup_anon_rmap to upgrade folio->mapping.
> 7. anon_vma_clone: handle links when src is a lazy_vma.
> 8. vm_area_alloc / vm_area_dup / vm_area_free: add VMA reference
>    counting.
> 9. mremap: handle upgrades in copy_vma and move_page_tables.
>
> If this can be restricted to apps only and the app never calls fork(),
> then 5 and 6 could also be removed.
>
> If each page's mapping in the page tables is synchronously updated
> when upgrading lazy_vma, then 4 and 5 could be merged into one.
>
> If lazy_vma is restricted to anonymous VMAs where
> vma_mapping_base(vma) =3D 0, then root_vma and the VMA reference count
> could also be removed.
>
> With this restriction, we could directly use folio->mapping to record
> mm, and locate the vma using folio->index, which would simplify this
> patch series.

After looking over the patchset I must agree with other reviewers that
it makes the already complicated rmap code much more complex. Adding
this into GKI as an out-of-tree patchset is an absolute non-starter. I
don't think you can refactor this logic to be contained in a vendor
module and without affecting the ABI, but even if you manage that
somehow, it would be a maintenance nightmare. I would rather spend
time backporting upstream-accepted solution than try to debug
unexpected custom behavior down the road. I believe Lorenzo's solution
will have similar memory savings and I suggest we all help it succeed.

On a separate note, it's very encouraging to see more Android partners
becoming active upstream. For years partners developed optimizations
in isolation without engaging with the community or sharing their
ideas. This is a very positive development which I believe will
benefit both the community and the engaging partners. From my own
experience, learning to collaborate upstream takes time, but once it's
done the experience is very rewarding and oftentimes even the biggest
critics turn into supporters. The key is to listen to the feedback,
ignore harsh words and realize that people here ultimately have the
same goals. So, don't be discouraged by this experience. I think the
biggest mistake here was the lack of prior discussions or RFCs for
such a big and invasive change.
Thanks,
Suren.

> >
> > Thanks
> > Barry
