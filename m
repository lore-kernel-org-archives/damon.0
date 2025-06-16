Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E9BA53
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095807; cv=none; b=tGNJmMrUqTfS6cx26PLzcQSeA9PjEFwuiRFls99K8MY4CMDUzyL6nja9XkEKvwSVWmhF4ddue4qeML8xQNn7izoSq5Fl1s+Q0mXNjYYoCTidVh2akWtGoezZ6ftdcrEerwVW4yPDA+Ex+q9CqEpjY4oab2ihdXOIx2vRQ+CjpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095807; c=relaxed/simple;
	bh=4gWRKYjPld+Y1uH823VRVyouLBLTGOzXlpdHtiU3vMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJKAPuEscXSNVFzMNXSduh/GUmT+PRZNK4munZ3F8HDDl3RYicUoIvwEGITemUVrUPN7b3V3quZZW9KrKcMiJZu+ymq24G7XTzRRZlTaDSk4RTotCfLuGHAqoOt5JgbphKg7oJGgUyM0pHb2P5hrI/+M2jr50eyh6Cwb7LKH+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PYuLGaX5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PYuLGaX5"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d09f11657cso497195785a.0
        for <damon@lists.linux.dev>; Mon, 16 Jun 2025 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750095804; x=1750700604; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/4yKvTkyWVd/1WyBWdEpHbqHXZjmiKnTF2OwJ8AWbI=;
        b=PYuLGaX5pxYINbww7fNnIu4hWIxMdiRP9VkM+4gL+pPA254ZJiyu2geYgwZ2lq6pNu
         ezEnPm4Vt4jZfKAd9Rbcaw5axbKgHoVO17PE2HGXYoFRoJi6ZZasV71Es5WK9SYW0T9f
         1uXfnbEL5sQEBZ1eaSldFzq5hvJ4liChf5lUfhn5IQsM5T+4VVItAwDE7JUZ1FPSPOe8
         VfNwyrJevaZRBXBWR8Qwv4Iigo/UVH+6yaMrf2DMEpmoOCOlYBIjLDXHooY7eEJQGLrL
         PrIc4etxAMxZk5oH6H6xeLiVlICxlDPgVZDNaax41UWw5hlNwi75AbASXFZcQgvtrSIr
         T8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095804; x=1750700604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/4yKvTkyWVd/1WyBWdEpHbqHXZjmiKnTF2OwJ8AWbI=;
        b=bGCpz6gbmpWh52etAMZO1usNUhB5jI9O/9ARBqQ1y84jCBmYv+yrL9pAJllmOtGwKE
         p/QptvC0dmdaDjG9MyTwafpYpJxyhB//UfzttLQnWBJHoNjOKA4Bwb+UXmMdoxPc58V/
         wTfH7NSo9hlvFn2iE+R/c1aRqbftUmTiTAA50VNMirZRH8iw2R+7Xk7wnNsCwkvxal5X
         c7k//7M6kovB573BYwe7B6nQcg8TIcfg0hzNaiNGY820mAnTKfvLTVJMzTBmkglWJgTB
         +bUk0F2qKnqzrb1U0II6nPI1vEzSSiud2cd6DVxlYqzj3uOLBcY6Q+u370ppgiythl+d
         XSWw==
X-Forwarded-Encrypted: i=1; AJvYcCVTM2C8w4YBqJZqnXXvij6Fr5USR336UUf0mZmsQwshUir31yfUNC4+cW1dVOUlSuZ+678DSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbLDyn/IF5ducnpyYrlcSg2q9dLysPosfydFsTgSXsj/pMjoq4
	JyRPLAi/nT3RejK4eYhCpyVfehhUby35I9KBmeJ1nL59PY4RZECk80KCfdFbarXMrv8=
X-Gm-Gg: ASbGncv6Hnvc0w4Nn6HZkTcOCWnyUO0+j5Wi3vVc7TZcq9Kz2tLEF2BmC6G1+gWbPVm
	N81JixSY1BzigVoxuO3IDa4w8Y+Yq92xEuS7OBf97Y2vxR2n2uFpzdyuztobcSxqp6RlhF/NoTV
	Qs3pOJvXVYMM1gmCD6a8p3LBMpoQgr0F9l0IzRj87xp/nkFe3VUGJaNMXdHjeOqfg9OZFT1Dpsz
	0lezOKUfU5EjE4jLft/BM/9wG7YP5vd335X8vUfoYPXsn9PWQIrSs2KuL7otvYgUEDSLG+Jr3XY
	JEGfiLFTYZcNkyFeQuOV0F2Yh2ykjwbX6iWGNN53bhBRisZuIWNljoDLkw==
X-Google-Smtp-Source: AGHT+IHUYY/n0yispU7eDUw6kgUep9wTEjSSBo8Jf7TL4kZ2IW3kTqXn60pb1DKcSyyGtFKJ/3beCA==
X-Received: by 2002:a05:620a:3728:b0:7d3:8c44:b7b1 with SMTP id af79cd13be357-7d3c6c0962emr1601991885a.3.1750095804599;
        Mon, 16 Jun 2025 10:43:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:cf64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a0fcd34sm51514371cf.0.2025.06.16.10.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:43:23 -0700 (PDT)
Date: Mon, 16 Jun 2025 12:43:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj@kernel.org, akpm@linux-foundation.org, corbet@lwn.net,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, bijantabatab@micron.com,
	venkataravis@micron.com, emirakhur@micron.com, ajayjoshi@micron.com,
	vtavarespetr@micron.com, damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in
 include/linux/mempolicy.h
Message-ID: <aFBXuTtwhAV7BHeY@gourry-fedora-PF4VCD3F>
References: <20250612181330.31236-1-bijan311@gmail.com>
 <20250612181330.31236-2-bijan311@gmail.com>
 <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
 <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
 <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com>
 <CAMvvPS5bTUfAXy4g79tAq+1DWKX79b33Jt=UNBg-xR9BDa7FdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMvvPS5bTUfAXy4g79tAq+1DWKX79b33Jt=UNBg-xR9BDa7FdA@mail.gmail.com>

On Mon, Jun 16, 2025 at 09:16:55AM -0500, Bijan Tabatabai wrote:
> >
> > Which, you also have during the rmap walk.
> 
> There is another subtle dependency in get_vma_policy.
> It first checks if a VMA policy exists, and if it doesn't, it uses the
> task policy of the current task, which doesn't make sense when called
> by a kdamond thread.
> 
> However, I don't think this will change what seems to be our consensus
> of adding a new helper function.
> 

Hate to interject here, but this gets worse the further you dig in.  The
mempolicy interface as a whole has many, many, many hidden references to
current->mempolicy and current->mems_allowed.  External interface
references to a task or vma mempolicy is a problem i explored somewhat
extensively when I prototyped `set_mempolicy2()`. It did not go well.

Generally, mempolicy is not well structured to allow external actors on
a task's mempolicy.  Accessing a task's mempolicy requires operating in
a task's context or at least taking a reference on that task's mempolicy
(which requires taking the task_struct lock).

I will just say that mempolicy is *extremely* current-task centric - and
very much allocation-time centric (i.e. the internal workings don't
really want to consider migration all that much).  You'll probably find
that this project requires rethinking mempolicy's external interfaces in
general (which is sorely needed anyway).

I think this path to modifying mempolicy to support DAMON is a bit
ambitious for where mempolicy is at the moment. You may be better off
duplicating the interleave-weight logic and making some helper functions
to get the weight data, and then coming back around to generalize it
later.

~Gregory
