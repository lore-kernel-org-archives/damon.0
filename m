Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E69442FAB
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611327; cv=pass; b=awZMTDqTf1Chc4QGdNzbkXkP3PCZgxbb2QXdO+0aQl1Shxrj5P9NkNePBfqmIT+dJnLtFVrlZnebCo9Qq2ptBzCSsvrheSpKX2wXf2Dl+soVuW3lgDejMCVjBA38dcK2Ux0VVoO7nlkqJwMAuGKdmJbNZSdj+yTYDqoQzuTolVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611327; c=relaxed/simple;
	bh=Jzc8k1yrWfBTMmPd/uTV9o0ew6ZOvHlbY2BVlHKCDmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgFGSQQepINFJld7384NJQ76jMHPBgu/97Az13bme7w5wTReIPc80ofwrv26Hxt1+zYuA3DJSszJpIClUZfkNmK5jlSBvaqrQNrHlK0p9kwZCxNRuH2pojd2aeGoDkJMMT5Ulc23aD9R3RhXogQbbcwAoX3M7vnD2rMv4uhesps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+5UcjpV; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+5UcjpV"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca7c1176317so430933a12.1
        for <damon@lists.linux.dev>; Thu, 13 Aug 2026 01:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786611325; cv=none;
        d=google.com; s=arc-20260327;
        b=iwe6P71ivqn6P1djLULRaGZ+7/RHuMRzwAcuP883my/ckFbZPr3KqbPOMuHawrD4bt
         GjbC4PPLJvFrQFxBNRUeE7mUZ3vVeoHWIWhUjCO1voTPgGnzoHUKHBwCr+wOg7Vf7WyS
         S6ia1Z2cr1RX7QbTeAlxblAainOLISZzNV2bNuN0fUxTbMVwsRNGS3iV0kgdSk8e1c3E
         2TeD4w7TpMY0kHBRZthZq21xaajBwYHrWy/seLZkwJ5Seq+m4Tnw4FqSC4Xwnc62UcMh
         hdm+7guEJfdvi9QpNJmru6HlIloEiMHxfmCHjW0qSdAP6/BZ7OiB1SYuAUDn96/k2z+2
         o+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        fh=03bKMx+9FWVbzFW2eR7+BRQHgvyW14+2vVlGHZ74h6w=;
        b=O0qP/Ni3Kk92oNRk22schD6eKychYrGkOfgdoiuBVTyDaI+hha7UKIxJpB1o9pAW4n
         IiVTv4YBlLAdgADUNPV0uVH7367xIo+yvfa6Ry3QxcFrGaNTqify/kRWOF5vVjzFANi9
         ma8tBjNwXJsV7T96XJBTsrXtQ/aaK5/PGiBlDd/jtpMpLqFpyG+dzD6576JRLS9LKdBD
         kyYR8aUyfZkjOVzs4d/+nHeyTAbabv0woYAfjpdxqkmyRdDRKwyrqNpcVF3tT9TWbXB+
         XiK8hyuJuAuQEnrGtXoYxprcMr+SoEbjrg3qxzB526fmy6ofAPnMFG/il/QsXrOOycIM
         ftMQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611325; x=1787216125; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        b=F+5UcjpVBRplijmxQSvRBTO82+o5SwKCfhOA3TjPyujTw2xWiWZnZ8zLpKMJuA4NZ5
         EkmffUQYA+Wc8in6nba6ZRH4CTpBkWJq/HUrDR/BNQKsLQQzqmlle4csYzfvjP9dax1K
         48l9z52J2KplaIJ+lYs7mu9YxAkQG44Ic7KAbSv4SaaPHX2hHGJlG47XSdk1tKg1nTzm
         AbDcJ6ZABdCm1bxsyQOK/w7c8ceO3xSHCe/SgmkjFEQuSveLV5mPT5I41bxbL9sSru6c
         enDqYvmfrLegpM5eTAhIuPBHP/ZwLQP2a4S0Nbb3HwAfsz56+Y2HSg0/dl/WO2lzOh/x
         9e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611325; x=1787216125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        b=Jei2e2lS5W07BLAAzWh8C3t1ZF1KUjDsu/oO6n9Iz/j6dY9rlAaYt1KOcqrgW7y06R
         L9AP/LeJDjRZLWolNBlal7rA3k3fI+hyeq6ikohSwtzUBT9480ts8qAdt0BZDiklIaJ7
         o/es7Y3H9UzSaveL38A2C2XOyFvkBwc0HpjzDSFJHK2HhE3GASfvzlM0+YyErAWZDqAC
         316nXAWlvFJlaaRA1wWLAbh++jd63d/TUe7EwsRWGX42lBf2OKKSrOAdr6w9XKjuUPnG
         TfR2NydXrpWnGAg+Enhx0xTp4pVcPSUpC9nUkdH92SUcMPZGzbaHGBNydK+zrBtUiEoP
         rXig==
X-Forwarded-Encrypted: i=1; AHgh+RqLZBnhsbr4/FCrwkSlLh3QDyN29SkSNnZ2spmC8hNutS6L5maSEOfA8gdMimk6fRB2pDEsLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyya0SrOETnFrwE1VpFEHYnGydB/aXjErTvbWMpfuzvgaG01Q0
	pjseAvYXc2qRwip0bKQ2VqllywpiZhc+ZvsenjcpQuxXlcP7LZ6WE4KZtFRnKYrCHGkKoVCaFnZ
	E+u+TXDtiGeREvev9H4YFliJw0D1YLl0=
X-Gm-Gg: AR+sD12rhFd5mHwZCkAtA9AGWQJ+AtbqXEuQloGvGG45MXfCXMFy7GXJNIQ4Uh2DA+D
	Lu/0FAl5ItH9T412Iuins+E9lqQVSAqshVJELDtctl4IoOB11sq/JgUgYpV3ZrMNHJ/UbIyHS2g
	0+F9mFBP+obuzKpwzYhiiZW8yyyfLz85viJtJLg0r8zlvB+Hjajnxy1tQy3gk/IL2q6UA3l4Z1X
	YEWem+WludKCz7JQICvBiajYOe05oHH0RFuCjI9U0QeaLzCh8KytWs9E9ZpJUPnjgLDEufyzLvT
	0VHXjyjlKdiIgTPEv5jo+i3UY3iVmW+U+yKXrxugNR6nCw4=
X-Received: by 2002:a05:6a21:150b:b0:3bf:8604:9a3c with SMTP id
 adf61e73a8af0-3cc553f513emr5787899637.28.1786611324791; Thu, 13 Aug 2026
 01:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260720193431.3841992-1-gourry@gourry.net> <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
 <an0cAMh_m8ZhGIm2@fedora>
In-Reply-To: <an0cAMh_m8ZhGIm2@fedora>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 13 Aug 2026 10:55:13 +0200
X-Gm-Features: AUfX_mx5aRT_GeBsew982Oll4m1v2zeTSERp4DtDb2YI-VK1slYjLWUFWPkF2ZE
Message-ID: <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	djbw@kernel.org, "Gupta, Pankaj" <pankaj.gupta@amd.com>, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	lance.yang@linux.dev, usama.arif@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

> > > Bonus Configuration: HBM device memory tiering
> > > ==============================================
> > > echo 1 > dax0.0/private       # make the node private
> > > echo 0 > dax0.0/adistance     # highest tier
> > > echo 1 > dax0.0/reclaim       # reclaim active
> > > echo 1 > dax0.0/demotion      # may demote from the node
> > > echo 1 > dax0.0/user_numa     # mbind()
> > > echo online_movable > dax0.0/state
> > > echo 1 > numa/demotion_enabled
> >
> > I am bit confused by the HBM device example being discovered as a DAX
> > device. Is it to
> > only to showcase the use-case? Or we see HBM device is actually
> > expected to be discovered as
> > DAX device with N_MEMORY_PRIVATE?
> >
>
> "actually expected to be" -> no.  there's no requirement HBM be
> discovered and boudn to DAX, DAX is simply a convenient intermediary
> to memory-hotplug.  This is at best a demonstration.
>
> A device driver could very well just call memory-hotplug directly,
> or its memory could be brought up as a private node via a boot
> paremeter (which I have sculpted for v7).  The former is preferred,
> but there's a bit of a chicken/egg scenario for bootstrapping.

I find this interesting as this appears to be evolving towards a vendor
agnostic framework for hotplugging memory directly to private nodes.

How you see this working? In particular, How would the kernel know which
memory ranges correspond to HBM or other device memory?

Please also CC me when you post v7: pankaj.gupta@amd.com

Thanks,
Pankaj
>
> Most of these UAPI extensions are going to be consolidated into a
> debugfs interface for testing purposes only in v7.  I've been working
> on aggressive Linux Test Project test expansion to ensure there is no
> UAPI regressions.
>
> ~Gregory
