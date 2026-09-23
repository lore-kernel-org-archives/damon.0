Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF1477294
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199995; cv=none; b=IibgJXCvrDU2G+uk8Ewy4enLsd9R92vORprv4A85yH+x9nCiLYGmINBmXo4SXwL0F/Fe6yaYAm4oN1rDMQFXK7/8IqTpApTQZezgEgTZZUhcVgcl/O4tgoABfPUrrqzqcFDLv93rgfIr8Iy35VrxicVf0Sf+pi5PdFT6YWp+f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199995; c=relaxed/simple;
	bh=xdMUdk2g3RQS68sUHf1oVBCGtOm3a+cNh4Vyy2wH/r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVZ2LYaa/MDtcrLdf4NvTLypkDv++5zTHZW7cffbA+0nSBfwdZcU00S5mKKEa4nc57F07q9IAT8AGDt6Ilwm50XSW0owXKZ4nBBOqNk48rvGfnMUoFgc4hoONnLA/0dFszhJdeQtV+Z0WvDkLkJMx359tojPiRVfdjRmRNhTYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWYP0eK3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWYP0eK3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso10077095e9.2
        for <damon@lists.linux.dev>; Wed, 23 Sep 2026 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790199990; x=1790804790; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CWYKTy9ur2zfAfW3YtEaKW/NAKkIGa1U+2owoaIL5wE=;
        b=mWYP0eK3F775KNjfQK/nsw3cCKq7wSNUXoj7zPFsOmqRjHIgmyFEEyatOqFue/dOtp
         KeLzZtb/1IHh2ds3QeMTj7k7ArmCZowma84/ktwV/uW49N6PC4gGOpdvCSJdKvZ0t0gj
         PLDIegAdGkn71eXNXxP62T84fhKs4UJZ2C7JaRLOm3kP1T7rnOZlNXt7Cl0xcK2Sl4C5
         y/iFVd0TN6iLJ17JhpAr5AKhInCYjv0+AQr7yTccbKcvtUhlZgGk3YRAaRZbrzqdsE1O
         1l3o17ptZS0QOTd7tmqLsxRVA+r6M3cMLmKmYIz1qD6c4Eqz2MN3+zT8LZlsMwuhsvHe
         5Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199990; x=1790804790;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWYKTy9ur2zfAfW3YtEaKW/NAKkIGa1U+2owoaIL5wE=;
        b=GiEXriXQpaYb0U1Pp00yN0qQJmc/OoHYWKQRCIwbxhlMauPjexUUsmyQPObPUGhIkC
         edYhsxvyVyxE/7d5sgM609u98OFX0R55SB/XRP8/PniPvbi3+PHkUiwUVzC2ywEsiXZJ
         DnEq9nYNNHUjVtLvZN6rB8ISyXFzGXv1+Q9GFQ2HD3ZbJjwexKODvVFaCuueR1PiiyLw
         AmQ0ZCVkcIk6aACxIFpqDDHas91l57kzrbhYD2m/fGyIsgNPs3Q9ZMzh24wePu4Z8uDC
         P58bEXlqrZkezaouFGdTNpjCNb1umH+dQ3tOaiFswrhi613psz6z/j8fKGtaVFsE4jkf
         v6uw==
X-Forwarded-Encrypted: i=1; AKwUvByOxBqg8NGXvaUzrqTuX7c9B0VGUITl8clq0cqnKTvh62bzRHvNSd4WRxjpH69/Lf6/mfYZWA==@lists.linux.dev
X-Gm-Message-State: AFuF++ln8F6aIfZXpfpJE4QMgNV8u+0EZle4t8rKUHLFDwQzhzaH40OF
	IUVfNwUI4hVFwre0KMIrqBxJ+d/3OdEEzgE5joo2KVE18M9GkUStkhP3
X-Gm-Gg: AYBFou2KCaNREeoz1Jv3T1WqBhKahjFwZIHzPgI9Da+ZC6/cwKmbKRepVXR6nnYKaa0
	Pe5cy1MGVnAtMzyW8j4Jb2A+TaTzS9G40zaXSvxcATyhbSyHge7TUBR1KuuQqJy/IRNRrK75B88
	pqh0iMHoxwDxC93lZ9Ftg7jPmSLacfoAxy03K5sV0OwvLY74DnYaKy35PKDhZjPr5t4348BJhF+
	e5NLw3+xolpoAdIDrPRoPiAlKuqx2Ta33QGLWcJtSXnVgm9I1r/z+WEud6c1qjxUcO4ozeoh8PE
	j8vj1x/WHb6X05+6SwHkhD5YOmfIYUBYCrXgiOZ7+D07YEl90hoh7JNRY5ZUmaNY5tW5yTfwEdQ
	ei9npkFYXPwm/LtSPVlr/BdI8mYj/qVauXw8obcFu6uptDD6GvxulnufQUpqCGp01u+KDBNAO8l
	pShLf8w3Q+cyMHCZmxwL+9vqH5HSOfPVKGGNAEj/yhkNyEU88mehB/pbhbFGsWQ7t4fts1diRsB
	v1ZliV1tAycb8xZucFunQkp+suMe3FWi/p50CM1V3a63F8V5YxHRcnaZjvb6lSiHVmUzLp4g5xm
	kQkI3pvnyu8VVv5rfNZTnMnredkzqKUKp1gXxCEf8ro6d8AJrr4qKeHxPI2ezQvxR7kTo3zTbwi
	mmdhoGx7C3xgVPIk=
X-Received: by 2002:a05:600c:8b22:b0:49e:7d25:f397 with SMTP id 5b1f17b1804b1-49fe66d30c4mr8601345e9.15.1790199989777;
        Wed, 23 Sep 2026 14:46:29 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4a2-9601-c082-2dcb-3f3b-92b8.310.pool.telefonica.de. [2a02:3100:a4a2:9601:c082:2dcb:3f3b:92b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe43fc27csm26083595e9.2.2026.09.23.14.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:46:29 -0700 (PDT)
Date: Wed, 23 Sep 2026 23:46:27 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: preserve the caller's quota in
 damon_new_scheme()
Message-ID: <arRHl5blMrrmvhkU@gmail.com>
References: <20260921171155.3359-1-sj@kernel.org>
 <20260922120845.44460-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922120845.44460-1-sj@kernel.org>

On Tue, Sep 22, 2026 at 05:08:44AM +0100, SJ Park wrote:
> To calrify my opinion more, "caller's quota" feels unclear to me.  I hope it to
> be more clear that it means "the quota that is passed as a parameter to the
> function".

I've made it explicit that this means the quota passed as a parameter
to damon_new_scheme().

> > > 
> > > damon_commit_ctx() first copies the running context into a temporary
> > > context for validating the proposed parameters.
> 
> I'd prefer using the term, 'commit' instead of 'copies' for clarity.

Changed to "commit" for the context operation.

> Now I understand you added the comment for commit 60bd24f272d0.  I think Fixes:
> should also be 60bd24f272d0.

Agreed. I checked the diff and earlier callers. That commit first passes
the running context as the source. v2 uses it with a plain Cc: stable.

The LLM suggested the wrong tag, and I didn't notice it when checking it.

v2 is rebased on mm-new and passes all 46 KUnit tests on x86-64 and
i386. I'll send it soon.

Thanks,
Karl
