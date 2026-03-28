Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C0155A5D
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774721311; cv=none; b=bxhouNZtiFG+Q6qFbDl3l87pJ0/U4tLIjJ4EpJFbmIm5rdATnbR2DY6OtXHshSKfkxciLtwJktoJ0j/LAUc1GqAKPrVlzvStH9JMS4vjbhnmBEEs0aP8z8lKg2xyWE8Hr2INFffMLpnQiWCP1A/UJPrgOeU4gZL4r0q2M1vE6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774721311; c=relaxed/simple;
	bh=yWOIgU0byrqD360mpduBSQ1t74eRNrp1ySBTgU64MK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWn+VeNCB+beuWFn+81TgIa/8m19CKwN3pF+Sw6No6EqTYOrRnzRN4bsYu2RtCS3Io1DK30jysRzu4uxyuC0YZrYzTwV4+a68vJBwbuDb+CIVBjT352uHjL8B/BdcMNvphVzHJyaYx6ZXIK/EgC7mhJkdIjXNvuzfNZiObdSXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1/ifwfW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1/ifwfW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c70e4654eso1364108b3a.2
        for <damon@lists.linux.dev>; Sat, 28 Mar 2026 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774721310; x=1775326110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diZhKCC9I7JLNY07BvTldczKweLaMhfWrzg57y8Kyec=;
        b=Z1/ifwfWDtNPkkzk4IeV416iuUsbAQ/mX0nL26XSTVULOLVhoZlZWzLtSkm4hLri9T
         39iJB3cZPw9kGfUdTQKgrnk3k7K4tD7R0boICwfOuBipWoSIbfNcKrq8mUz3jXdNC82w
         aERZBgdAX6lgYYpJuM2zI/Y+Pfz3rdJmslFv/8w+axy5XnFCbaQB4N983GKVVmgdywQZ
         VoAhwRLwjBUdt6XswnisxEYu8wwUY7UoTqwd+m24HN8MnDXrQPx527lUE4esr+Q/pcw6
         B0BO6WklNQ+rO0hYGV7CajOrQEwEFY7f/2lY/zwjvOt5iPLo5wd3diuJ8V1J57Kge+r5
         n6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774721310; x=1775326110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diZhKCC9I7JLNY07BvTldczKweLaMhfWrzg57y8Kyec=;
        b=rPz5RIYjwYkU2l91kdc9xzm/T7RsUTkfl2KEuOzr0B55Np9fD5FloUZme63RVaQR4L
         8B5U3lMLNGODsBXJVEJ7WztGsoGLQ+gUdSzkVA5ge8/lzuSXG+lg7Ykud+dznHgqPCz1
         y59UPAFfynxFizw6x6mLOERAN3t+OzvaqIN8CwJYDf64Yp2QWNEcZ0OhtCCCFo4VYhjs
         9dcfzfI9zaCdVxUDm30A4TogxQiUA33VzUwGY6l5CRgfyzjkW5qHm8mSahepWOt2/lpD
         cAqk7hBkfwRXdWyzqVs9yPWHZjG1UVbTFUEwEQHr/ooP17gA2PV1l3rnwMZfA+VbryaC
         g+5g==
X-Forwarded-Encrypted: i=1; AJvYcCU/i82VwBnl/5gQEJs1kOdmTBbmGv7ohAU8ZNVduZZBgOkpXkxapJnina4bbnKG2JYu7PLucQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeBdCruZ1d0dPPCTAe6vrRWSyr4zvb3c6Zfpl7GSEF+Hqw/IuT
	1bI1fsG2wsiRvxyvpoEZNp8FNne0hgdt0ve4L5qPnH2TLukJbG12J/2T
X-Gm-Gg: ATEYQzzXBioJnjt8wHjXcsjRp3nRSYpLmo9toS4hNqIttzRNAmGtQqlY4nV6ELKFt35
	eL1XcDs7PwXOqewxtVWSIBBR3vw8/0X2aM56UUbEaT8Gm+xGg6WWhmh9Z5b1/hnYu5f9o4HDvuW
	rdg3HGd1u4XpSXnWmWtLUSu0SrC32j7FuTnSoKRVq5zgXg7bouq1TKI58yr0OROZR/3LkK+H+l0
	YkoHzWhe6/L8zpMaaUyyYKfOaCeukuG7fOY1CWJA/ooTltvpJYir59Do8S1DngY4HUV+RRqAUwO
	wJmnaUFmDbipe8iFN16iykUUMfDYTfUdoE6V7N7eEse9LaE0fnOz+JB8Hotp0VoTKYSgWjwilBV
	jxMmC/DPhL6WLpLEbhNQTj/nAIi3/GwTm26ypMNx/qfwOdQ4k4A23/Dyh1mhcnH9122r/A2BRMM
	TW3SZH1sBpJqcvZACQPst8kYDgWqg=
X-Received: by 2002:a05:6a00:3405:b0:82c:77cd:50e1 with SMTP id d2e1a72fcca58-82c95e45397mr6087053b3a.20.1774721309733;
        Sat, 28 Mar 2026 11:08:29 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d3a71sm2969211b3a.30.2026.03.28.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:08:29 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon: add synchronous commit for commit_inputs
Date: Sun, 29 Mar 2026 02:08:27 +0800
Message-ID: <20260328180827.8136-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328140907.10389-1-sj@kernel.org>
References: <20260328140907.10389-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 07:09:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 28 Mar 2026 18:44:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> >
> > [...]
> > > The previous module_param(..., bool) macro used param_ops_bool, which
> > > includes the KERNEL_PARAM_OPS_FL_NOARG flag. This allows parameters to be
> > > provided as a standalone flag without an explicit value.
> > > 
> > > By omitting this flag here, does providing the parameter without an explicit
> > > value now produce a parsing error?
> > 
> > To be honest, I was not aware of the implications of omitting the NOARG
> > flag. It was not a deliberate choice on my part.
> > 
> > SeongJae, what are your thoughts on this? SHould we stick with the
> > explicit 'commit_inputs=Y' requirement for the new synchronous behavior,
> > or should we restore the NOARG compatibility?
> 
> Should be a no big deal.  But it would better to keep the compatibility unless
> it makes things too difficult.  And it seems simple to do.  Could you please do
> that?

Sure, I will restore the NOARG compatibility in the next version.

> > 
> > > > +	.set = damon_lru_sort_commit_inputs_store,
> > > > +	.get = param_get_bool,
> > > > +};
> > > 
> > > The commit_inputs_store function parses the input into a local variable
> > > commit_inputs_request but never writes to the global commit_inputs variable.
> > > 
> > > Because param_get_bool reads the unmodified global commit_inputs variable,
> > > will sysfs reads of commit_inputs unconditionally return 'N'?
> > 
> > This is actually a design choice we discussed [2]. Since 'commit_inputs'
> > is now a synchronous trigger (or a "button") rather than a persistent
> > state, it doesn't necessarily need to store the 'Y' value.
> 
> I agree to all Liew's opinions.

Great! Glad we are aligned on the design.

> [...]
> > [1] https://lore.kernel.org/20260327233319.3528-1-sj@kernel.org (Lastest
> > but may not the last fix)
> > [2] https://lore.kernel.org/20260323150544.81042-1-sj@kernel.org
> [...]

Best regards,
Rui Yan
