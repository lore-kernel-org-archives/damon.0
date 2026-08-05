Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196E3E5EEC
	for <damon@lists.linux.dev>; Wed,  5 Aug 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917570; cv=none; b=tE9EOTezt7VfEBz1no/buK7baSWiC6l2WTBSpQqnfNNAG5sk16T0h08Bl9BCFrpnr49gPhLTT3g7bW76tlbTaLydej7H61AFgQ4ImGwbFLQXK6TgtEf07mpXaPEoz6UMvQ7yeu8yGZexp/mcJbsbfJo9l/wmVTH6ukVocFOxa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917570; c=relaxed/simple;
	bh=kC+AXGx2J9ONhXrT65r1ccDBDKZJh0TKShThSZmnH8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGLW9YETm5Zn3/rP9xsoCQuhhPk0MjGfKZn8PaLE0AdVHdMJzuZRbhaE6c1zT3GvxIJmSUnwBroajZPXeKZQ3LDjuS43KjG3mAIGjt+z8CcSfIR+ACtYXxJn8jf9ILBvpKnSp5ABx29EREsdfhFUzT+jlBSzg2hvXTt6kXhzXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQNW296o; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQNW296o"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca12086c06eso576122a12.0
        for <damon@lists.linux.dev>; Wed, 05 Aug 2026 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785917557; x=1786522357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tI8sU3Lw9QYzBWqTxRt0CmjJbY/DDf+DIW/Y/dz+Tw=;
        b=GQNW296ok8zKpfd0IijT2voJgIMQgJPaS2bROHWbx84X+OngHyzcS3vu93n19rX7T5
         LGfa2r4v5eUQluzBFw5VK125Nfufykh2z2nU7TI+TeZ+4dKHwous3wcglcVUdVsxen+C
         3jmAsRpDPiGbWS7SPHICKkWUru9QuFfiA6tbSRAF1QMGHa4grngiJKfj2iMntiXZ4VFX
         3gA1FYJEKtIaGvTEnVqLu2vsdNTUqumUfNuYX1zEsdNYWxaxDhuY6b9rAtIiyOnalLR1
         WTQ0mgj5o16NQWDew2iPUJfHtyFHe1jGmWX1r74iGvnGlOAcn5ybr8EEwkL1CzVdOPkz
         GKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785917557; x=1786522357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9tI8sU3Lw9QYzBWqTxRt0CmjJbY/DDf+DIW/Y/dz+Tw=;
        b=r/sjwj4UN9tJvrEiv88UjqGTZaSfPi3l5Lor5KyzYKm/ldR37r2gVpesOmwizdnVoV
         8MBYwOcNGWlkNP3C/29qZRmS72y2g2U/eKrFgPPvbTjs9M7sr2kCdcqSFrtgFxeOJIoS
         SPYNH5RU9d6Qe7ITfaNJwPA3EZ1exQ0gFIcj+1tZKDRfrcapB//WAKJgSH25lAmm8QXU
         HKOJi7QY+17J0eGc471/rTY4NxHPkQa0VUOUPfX5XkPX4kk2BeLLrzqNfJBBnc/gh2jo
         xYLSgJwppBh0e+voxXz12APQlHU5m7qXtzezCISJbaeeWQjxbmNb64hkFbezGX1pHLdB
         A+yA==
X-Forwarded-Encrypted: i=1; AHgh+RodkhxVdQ5wZkNBryHd/AFfiOtNA+Dd/dwHXTNjo2gnZKVEmqvdv0AdIOp3gf1pVmrqc9lSkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/XYhAqL9RrQJK+qoBTaV5TyjqNLBz70vE/+vBU+jCJbO3vdXQ
	nAI1e3v4e6t3fPhJtL5DHhrtTTZkWv9kCOjFnMNIN1ibX/amlbLPy/5C
X-Gm-Gg: AR+sD10orYqO9kAdEEOjf7dwccCBDgR3nn423lEJLWVqR6plHjjvkA5qJro5cqTTwau
	9vi3tg/8a24f89GLp2FtOf6iiIhKM8sMvO7rT3H/F8pGPzfNJhr6pg6jgTqkOpvavebenHCZmtx
	27ppAk6vJQneJgL8O7N71lLgYbmdvih5XLmjl8Eaw+WaKjNZF3QmaxWD8paMwjmtHhNuwPOtw6r
	EUiL/s1jM7fDoIFSHi0BjWpbkD7fDaxkFyLM/XFgVR0znZP8ixJUvrg3WY//aEK4HZA3HOm7yNq
	VJ6Y0kFHIY1i+n1iGXIjOX0MgWakuRLlX5mB4VOyLJZWyJbb5hvP8GjRKQi23gctyVy4Yvxvc/a
	rzJrfchffnLBVDGOTqB+TyeT8X4tGAYceTFTz/I+kpCszwtpPWR5UiX7v167tGHqPTfZI/y45jg
	WwTdPGrqM5Qj4KdIkETXsGLJtGzl2529Ai4TWTP56MPqMi4NugAeR2KHd3TJWLBiF3
X-Received: by 2002:a05:6a21:4685:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cb85f4a279mr5957110637.31.1785917556844;
        Wed, 05 Aug 2026 01:12:36 -0700 (PDT)
Received: from celestia ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe7092b9c6sm1014573a12.31.2026.08.05.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:12:36 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: introduce damos_sort_type for re-ordering regions list
Date: Wed,  5 Aug 2026 16:12:46 +0800
Message-ID: <20260805081246.39417-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804135834.86511-1-sj@kernel.org>
References: <20260804135834.86511-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

First of all, I apologize for the noise, and I will drop this patch.
Secondly, thank you for pointing this out, it made me realize that I was
fixing a non-existent problem.

On Tue,  4 Aug 2026 06:58:33 -0700 SJ Park <sj@kernel.org> wrote:

> The recommended way is setting the min_age naive, and auto-tune it using DAMOS
> quota or aim-oriented quota auto-tuning.  Have you considered using that?

> This sounds like very similar to DAMOS quota's regions prioritizing mechanism.
> Have you considered using DAMOS quota?  If so, could you please add why
> proposing this new mechanism, with some comparisons?

Yes, I have. And you are right; the existing mechanism is better. I
wrote this patch because I misunderstood quota.min_score and did not
even check the implementation of damos_adjust_quota().

Whether when implementing dama [1] or this damos_sort_type, I failed to
realize that min_age might not be such an important parameter on a
long-running system, and there is really no need to introduce
auto-tuning or a new mechanism for it.

> I to be honest feel this is too much for "just guess" based patch.  I'd like to
> get clear reasoning of the change and/or test results before reviewing the
> code.  So I'm holding the code review until the high level discussion is done.

Moving forward, I will ensure I am not "reinventing the wheel" or
"fixing non-existent problem".

Thank you again for pointing this out. In the future contributions, I
will try my best to avoid spending time fixing problems that do not
actually exist.

[1] https://lore.kernel.org/damon/20260628085155.20828-1-aethernet65535@gmail.com

Best regards,
Rui Yan
