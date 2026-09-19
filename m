Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA771A0BF1
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796657; cv=none; b=Rk3OVIgT/LKnXVLNlElGnJ5oM5LbT5cXfzhkD6gPmylR1rwm+wwD2eFFe2WH+/ISZdTnKjFh4IRi1K9fq5IjBdM1SYGBDsOBG25YwGElfN/cukUVjhCLtAtgmDufWqxQni7/MqBXLYwBQdAALl0nzwjpbi5Cz34+oc5a+TOf+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796657; c=relaxed/simple;
	bh=nXQcnOX6QQenr0BQhIKwzKmc5cpqd4wJ5yRBp7AjTJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smLpNhkano7biVZzrmn6cyPpWUb5TeFWetvTguubR7pbMp+gwBFIkb3v50b3G+HyiqNcJi/uQTFIJaVtIWF2BWZD02HsKngSMvLd0TOrbAwxJGzewh+2+iiMvr+bNIVbCrnCuhujcJrKK/5PbI4lsFRDIx5gUJ/VWsmd3S6EarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM0SApaj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM0SApaj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so8082635e9.1
        for <damon@lists.linux.dev>; Fri, 18 Sep 2026 22:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789796654; x=1790401454; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eycts9u1BqM6pEzcHLiCKEjmginPPloZHsyT+3j+oFc=;
        b=jM0SApajR8Ck7kDoSxJz+uNsoHCdPz+Gl3Rnw7wYsRQkiQgpKD7r6ZofDw5LAR5/Ru
         +mQAbfDmHKeV8iF7wppmPJMoGq8w5kB2RQNgL+1U7a+GijbEUmWGJ+Rq6Zv0B6e0Rzlk
         TC7e4PnnWvFVH/XBJ7XKKa9sYNG+jPrWKtdr8zo+ICk85Tjl5j55C8Tb/xFn4Hi/fe3e
         WSwtM3fy3uuL3O4dQPmorh0nf8d0H9dRpgrhe0N8a6UCUDWJmols9vx10lp7YLvxSoS2
         6MekF5uTa1X2uY/uBOhxeYONAtoAnSfBPYHDYtN74/pma9HyD5Nzzkx/BJqZKpl5nAdm
         5p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789796654; x=1790401454;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eycts9u1BqM6pEzcHLiCKEjmginPPloZHsyT+3j+oFc=;
        b=qfoFM6E1YKtPK6x0UOZsisnxGkZMAUWC/6+KaAQj6KQxzjxwarT6ouK5pr/fLTExVR
         h/xsom3uDei3g2VReZoFgnucNmc11tzNXrw7HHH4XzpwOlEiWVUHR1B9mdf89LsTwTna
         dH1TZB3FZdQ9Xnajj5KT5exuW/KpJsjMN/LisFkIGdgBOloOPF0Y/m9kdYjmRXW92i2e
         BcLqyrqNyL43i2SbTtTGa/zEhCP/IvxkeIriflK3EZXrmvf2t6F7HnfxFwndEqff/hhz
         k10T/MXvlGHCpIcqJ1GPIzLAv0oJiUuokD0TEOWWrpuZTbigr/QW9nmyFZum53ol2yx4
         j+qA==
X-Forwarded-Encrypted: i=1; AKwUvBwMYMN9dxcrfGE96SDro7KFt9aHRDiF5KAjEuhQvtnw6kmk16iCdm3sAf9PY24n9QhPprxdVA==@lists.linux.dev
X-Gm-Message-State: AFuF++luVyPQ6Alo059qPGqy6rSABhnxR2E1KA419a/gb+2XH0SNyWBq
	nInpGxr7x3IXaPc8WospYMI4HgeJFZ/ttVJ6mchRBQz+A98fwlpEKBIK6murJP6K
X-Gm-Gg: AYBFou25aq6NRb5IOiQA12CpgnaKftLcHdRaYnSL++AtJVui1y7ngLGHoJZJ1Fxcj8Q
	vEUluOMIDWjZ8PMsDECLN229hqdjka3ddsShIxu9sI+3HbT1jVfIPg4KeUUUnNlxprMlC6d1jEG
	J4DnjnaV4JxT9D7i0XcFqFXX0FgoKQqhgA2hX+lXvI64x/fZCqW8aeq8+TxX2BV+XHlJ2dTVrvL
	5UZ0W1f9lsTXqNFfiX6wiZs76mp/Hw0iqDWnrXkJS2vY0Phx+dRNL3IaU/XGCpoVbNZ7o3AAjPb
	aLKGm0irPYtIpV3dvE89aCYAfcU3xjtLr2sLxtx09fpygRkAMOmUsX6ZS1tn8vQ7UDlg65k7aCb
	n3ymRCuR8hXPCWQW2Ee/2LiKFX8DA7Npf8O3TsRb4li7E92thOp9EMMKe5vgh780UX8HfDb6hT+
	a9i5V73Kagni2Yz5jbC2uoErOYYMDpysuHy3Vw9etFNl7iQmhVgHKGzxHPThTUv+wXnt/fa5l5s
	wY4TtFbUmhOhn7e2hk6jzTLRR9sFu0596zsjVzYhjRL0rJnNfh6j9fwLSg7FY0+4595ilzvr26T
	h4HT1oMFVqVoWXVynYPbo8kiBBhg+/YRqWBFQ95MLKiTrdU+6RwpwPA6eVpsW73aT2ZeN9SAvzo
	WcLqR0i/ZxBQ/bc4=
X-Received: by 2002:a05:600c:5250:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-49fc5746338mr64293805e9.18.1789796654317;
        Fri, 18 Sep 2026 22:44:14 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm251972985e9.4.2026.09.18.22.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 22:44:13 -0700 (PDT)
Date: Sat, 19 Sep 2026 07:44:11 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not
 achieved for the temporal tuner
Message-ID: <aq4g5W58PgWLqJ8p@gmail.com>
References: <aqm1ZPUHiXf9PFWq@gmail.com>
 <20260916001311.101024-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916001311.101024-1-sj@kernel.org>

On Tue, Sep 15, 2026 at 05:13:11PM +0100, SJ Park wrote:
> So I'd still prefer to just making no effect this round.  And my commit was
> failed at doing that, because it didn't aware of temporal tuner.  Maybe we
> could show whether the goal was achieved or not, using esz and let the tuner
> show same achieveness?  What about something like below?
> 

Thanks for explaining the two concerns. I am still new to the DAMON
code, so I may be missing something, but your suggestion looks good
to me and it is simpler than what I had. I have prepared a v2 this
way and will wait for your comments before I send it.

One note on the first concern: as far as I can see last_psi_total is
updated in every tuning round, so commits in between would not make
the measured time longer than the reset interval. But I am fine with
your approach either way.

I would also move the last_psi_total update into the new helper, so
that the helper is the only place that touches the field and the
unit test can check it.

While testing this with damo I found a second problem. A full
"damo tune" still gave a zero quota for one window, on the unpatched
kernel too. damon_new_scheme() runs damos_quota_init() on the quota
of the caller, and since b90408ef1163 damon_commit_ctx() passes the
quota of each running scheme to it for the test context. So every
full commit zeroes esz, esz_bp and the charge state of the running
schemes. Please correct me if I read this wrong. I can send a
separate patch for that.

In a quick QEMU test with your suggestion and that change, the quota
stays at 1 MiB over "damo tune" and "damo tune --quota_goals_only".

Thanks,
Karl
