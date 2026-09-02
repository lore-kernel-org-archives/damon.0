Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781137EFE3
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363224; cv=none; b=XZYyhvF5Nayv13sliZ3gCaTjybIN1pMpP9rNoUNeuWH2dqyJCCvU3z3B6qVeDm2fgEkmLch6jXGfjVY1630TCAAbyX9ENpYDa0ffKkC/92dtn9UubvWUldLWQE+uJfeVhgVRrocEITN2qP0KR3Wlng9L5r2eWu0nGHHiawwLkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363224; c=relaxed/simple;
	bh=73vm1pL2rfhflK6E/C/p/bdvtgGGIUR/9hKtxk/jREE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF6xKqOf6nYtPs76A9nsoXOwP0n8Dtqi9F/MR7quAo6ByyUnnftl7mG2f6HQBsDFOhoTg/AeTE0jwSmY/ZC66zoYEhj8AoeSO3LDs8RAmo+lijK8yr7gib3XJtQAW7ibo/2QddQWCyS4kMEI/SVDEZgQILqseFsXJNLWTuTJp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbECeZ/e; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbECeZ/e"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so2393875a91.0
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363222; x=1788968022; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jAwZDI989FVdGKLvHqYjpHzJ0A2k3qSizrEVsIJoGK0=;
        b=JbECeZ/eCJGJDQGcdF0TRNykIPmAiZRoFNFmyBog8q/gd/n6xNHbwbKRX1cOgTAYYb
         1khaZRmIA2pGClxiYI1m/gNfG9IAeuLLm3DO7Ty/ZOm+DGIyWUnl5w3m2jgNi2Lbsirn
         Sc0gAbF2+OStI3aDOVjCKyD/APCrFerrm/k8cW4+QNVQfzR5vNoN0FSu7OgSefHJS3zN
         bGnbcWGXZp1FCHM/3o6IrfKFGaftQWOr3JVZAcMaKCtIUK5COlzApdHvK48bumOs56hW
         X3IVLHLEKt/n53xVwRnMtMxpPs9jNnTux9X+8csGHYxVj7klTAi5A5WA4UJ5sKXI5FD+
         oyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363222; x=1788968022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jAwZDI989FVdGKLvHqYjpHzJ0A2k3qSizrEVsIJoGK0=;
        b=PSHDI3EoyM14DqpM1uqWWtQbbgJbg0/YR/fnQc9fB9cE4dguHDu5gQVl6KkLusuKOc
         u+78Xbj9RdnW+9EnhhVlOLGQPG3QcHyR1CA2/IC9XG3qCQFe7GCYOeMc/aI0YCTeh3To
         oWhGMtz9fCNYFSRLzCPRt2CNAm5nJhGkRdAevg+S+MXLUBpUUMeqsxPWDAkCNrjQsE5I
         tdxX1VKJV+7HEPtEoLChQnDtKU20zzdnuPwZJLYAdVd0Sxo5tneRgH8oXvdsQk8na+iy
         DTLgSY91zUZg9SKMW3pvuckj9J94msfSCJ+lrr0bXYK0aCoSacIsrBUjzeXAFL4EdRuR
         oj9A==
X-Forwarded-Encrypted: i=1; AKwUvBzirf9JFPqoCh6TQZMnnDjSwL6ZE/eGU04Zatwa6ayurwxU40opj+2JfJRXBSbnBDzIl10QWA==@lists.linux.dev
X-Gm-Message-State: AFuF++nIQNtclYTYMPse+GhRl7wgNzK3zvchcV3CyhIvdGWrdnHMSB87
	5jgEkQP2esNN2+xQK1O0SCCqEjkbnEMaOgzUxfTrkVEfzN+JMOiFQb0L1B+VBjt7
X-Gm-Gg: AYBFou2U3cIq3anp/xL1EdTn3k1VcKVocQCsaTUY8OaLujZ74S5i+1TnM3GZVDFJGwj
	P62CVHKMjxJ3NCVonpanM7a9cqUQGan+f6IrL/+peLWDzjXwvqyZR1+iGFpj3tlRO6H4me6X/+s
	Y3QIQeflNz8oQ1ZpY/RTVl1UhqWx5yyKXbduasIXW+megDJjjZYyDVeEjdgC2TgXbUpm1HYvxHj
	InSxVajE8V9nCRXfwGObbtlRWLBLqVJE16a1eAaM+wnP5eopdjk6tsF5SbZX2G/pp9Ku+zq0LAP
	pG1MSEDc49JFvJDpPy6gOdvoHXbOi6xBK4/PTm5PTomb1RKxLk5k9cHfvuZA12LCtfIXYQRGT8t
	HTuU7XQx4Otr6/ESYI0cPM6HX4bsofZJ2QJOJjc6KL49Fz0gV+Q34E3at5oZCEYtfWumuM7Po4C
	0GUVBbdKOsO1CQoS4gLmX8zlvjyyupeMlHtSYGud1z5VRgR4/ltYcAsEk8gOY=
X-Received: by 2002:a17:90b:2704:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-39b0860c252mr15953a91.13.1788363221587;
        Wed, 02 Sep 2026 08:33:41 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08627417sm4966a91.12.2026.09.02.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:33:41 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 05/12] mm/damon/sysfs: remove probes number validation
Date: Wed,  2 Sep 2026 23:33:33 +0800
Message-ID: <20260902153334.4034394-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902143706.88115-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 07:37:06 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 22:07:13 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:
> 
> > On Tue,  1 Sep 2026 22:47:38 -0700 SJ Park <sj@kernel.org> wrote:
> [...]
> > I was wondering whether DAMON_MAX_PROBES is purely a core invariant
> > or also an interface constraint.
> 
> Thank you for reviewing my patch and raising this question!
> 
> > 
> > With this change, sysfs allows nr_probes larger than
> > DAMON_MAX_PROBES and damon_sysfs_probes_add_dirs() will start creating
> > probe objects before the configuration is later rejected by
> > damon_valid_probe_params().
> > 
> > Since nr_probes directly controls the number of sysfs objects created,
> > do we still want to keep an early check here?
> > 
> > I agree that the core validation is required for non-sysfs callers,
> > but I am not sure whether this particular limit should be duplicated
> > at the sysfs layer.
> 
> I agree the user experience may be not that good.
> 
> In my humble opinion, however, keeping code simplicity is more important than
> the user experience here.  After all, DAMON_SYSFS is recommended to be used by
> another high level tools like DAMON user-space tool (damo) rather than human
> fingers.  The user-space tools like damo can do the early check.
> 
> Please feel free to let me know if you have any other opinions or questions.

Hi SJ,

Thanks for the explanation.

I agree that keeping the invariant validation in the core layer avoids
duplicating the limit in multiple places.  Your point about DAMON_SYSFS
being mainly consumed by higher-level tools like damo also makes sense.

My concern was mainly about the temporary creation of sysfs probe objects
before the configuration is rejected, rather than the user-facing error
message.  Given that the number of probes is bounded by the core
invariant anyway, I agree that keeping the validation centralized is a
reasonable trade-off.

Thanks for clarifying.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Sent using hkml (https://github.com/sjp38/hackermail)
