Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F6357CEA
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782636941; cv=none; b=ElOrzLwSa/uZA/pH9kvlJTlVqM80WbKLP+bEOLWB88MNB6xzBUkB8PVRgs0DZcwqWPvnqCa4gRVbmkDNTzkZDxEbywAkveIF1o0eegF5mrFR1fZQhGXSomslRqDJV22ekVG2tN8jxe7eUDQ7ROKCbZWo2sVkmSFZ25F9HCaAG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782636941; c=relaxed/simple;
	bh=nuuVvosaMLA05RiJjQAyNlrpBTVaNYtCJ0J9vCTdJRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNSXR8vIfkw0hpxP05D57dEH+gIwOcyW6sVb6Ki0PMjJ9jpmcnKCErrNOjOrcVA/eauG1m1TKGnh0rWpvWFClz0R0lBOmKypX845QyKTeDp/qGXKjCxJbQaOlwFrPkZY8M8M6m/YVpjoJyJjo9kqsjdFoQ2dumth9VnWF94X1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhnm3JIB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhnm3JIB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c7cfa17fedso20893725ad.3
        for <damon@lists.linux.dev>; Sun, 28 Jun 2026 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782636939; x=1783241739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj9dKjaq6O76EU+7+B1OfYt4Z5rjztB12sJ5obaAAZE=;
        b=jhnm3JIB6z1ihuFElWhvoytIVFdfxh2bzCfKML53gmgLnrhWdei5zcgA/J+vollpy1
         FJQSW/M4p0ayUVpf2wosRDdaIdN4eNlOo/dW4tfgiGILkrbffcRevXOTyxGLUkyF49kw
         mRVwdWtt++hKjy7F0jtOWa7Op5czkqWNJ0dtOkpCvZmmf68ZY2aUqCq8vhdeIzcmQ2Tb
         4zkocw6XG+w6l6PdSFcYku+BUUmSCFqivpeF/lzNPBhduVhQFg7Yrw7dPfFHP5L0XH0Z
         RswjCx2GdqfmxgD8RaNmc61qw4Vvc0Sc9dzGfaipZETKTPk50/9zzdaR6h/iCWfsX7xT
         SKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782636939; x=1783241739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kj9dKjaq6O76EU+7+B1OfYt4Z5rjztB12sJ5obaAAZE=;
        b=IGu9orSsKY7mpf47KAzMG93WkdweHhgubDpVNaweThtEBMWMgwehyJHPMsChlEcBeQ
         nscf12+l7xwKVAb+dTd3zAsTeGJpp4S5SV7+DekRQxOd6l+QHsreAtXq80QEpzRPK0Xw
         QfgDD4SOS8ST1n524uuUSr4mmuOhQrCRV8wy/iZ6g3M8gDFoPhQOQgPl4fdXZHAd2Gl0
         WQN5UsuDLrGFFAue9cu6Wo+7y8jAFhrE9zUaXltz3Mza69JLQ7VbcEs1vwjkygvI1XPV
         0ytJCLTC2qNSPo8EK2m4chbFufKqTMK54KyzMIH8JD9CkC5kJurwkVTtBdeV7vGd8xzX
         U7Xg==
X-Forwarded-Encrypted: i=1; AHgh+RocLpFeLfxpnuUsuSmSNla939w5qQFsWZMh+vxKXI+IElFdikhnvixaDYDznq50w40sVZQeog==@lists.linux.dev
X-Gm-Message-State: AOJu0YymsO9Pa5dMxiSVU8f50wQ6K1jYB2t12OtFIS4YgcrXqe6qS+az
	6Zit70XfitOOvrTcOI5RFNxFozvwrFtNYS1xzTBDKh08d4U9msqfvk8O
X-Gm-Gg: AfdE7cl/u3SC5pzy3y8OmAiuzqb1pWbkjJmXiTpH79q8hY1B896K2FmOb21ceig9tt2
	6Ncx+E4MDwAOzysoBfB0Ltvr49Cdix2ZqAv3YBCvt5jix530XfyGYuTuKOlXtsIjanpCx6s0QbF
	SbVq4x9w0iP5I7x9fAImfA+oEseEpbj3+pRy0QsoBwGa7RCBZm6xngUfyh1wS6kfu+E3HNEeqay
	l8JNn2cNzlvhU2QuVLJPf8XK4M8PwFD8ByjUytR67QDFk7On5XSKr/LJYVDu5wWEqH/aSx/MVkm
	MfFCCcUu295GDXsqRHJ/A4uryZxmyMS7BDEm8++zv6Qa3eUWGZuWyh7vmQGB8jJ0EMSLATJsF0J
	NBMyC1sQkCnS6JgPwf8/Ps83rZfLW2zBCHTSpl2TwsQkLsSI98WSWGZaCbp0+2bwgAZb0obpnsP
	IZaPb1Mg3gBGuL4dKc72GgnQnfqVTD1ibjEa9DSUKW
X-Received: by 2002:a17:902:ec90:b0:2c9:ceb9:8668 with SMTP id d9443c01a7336-2c9ceb98a66mr28705855ad.46.1782636939419;
        Sun, 28 Jun 2026 01:55:39 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9a5:e298:5467:317e:e807:794b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9bd5a3acasm20072895ad.28.2026.06.28.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:55:38 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an optional watermarks metric
Date: Sun, 28 Jun 2026 16:55:38 +0800
Message-ID: <20260628085547.21814-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627222645.26834-1-sj@kernel.org>
References: <20260627222645.26834-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 15:26:43 -0700 SJ Park <sj@kernel.org> wrote:

> > I will drop this patch. I think controlling DAMOS pause/rusume
> > separately might be better suited for execution in user space (such as
> > controlling‘quota_ms’ and ‘quota_sz’).
> 
> For explicit DAMOS-only pause/resume, you may also be interested in
> max_nr_snapshots [1] feature.

Thank you for the pointer to the 'max_nr_snapshots' feature!

> > 
> > By the way, I sent you an email about three weeks ago (Fri, 5 Jun 2026
> > 20:28:00 +0800) introducing a userspace auto-tuner program I wrote for
> > DAMON_RECLAIM's 'min_age', and asking for your thoughts. I am not sure
> > if it reached you, could you please check? I would really appreciate
> > your feedback on that as well.
> 
> I don't recall that mail.  Did you send that to damon@lists.linux.dev or other
> public mailing lists?  If so, could you share the message id or lore.kernel.org
> link of the mail?  If not, could you please resend?

I hadn't previously sent this to damon@lists.linux.dev or any public
mailing list.

Since I have completely rewritten it (the email) and it focuses on a
standalone userspace program/daemon, I have submitted it as a new
independent RFC thread [1] to avoid biasing this patch's topic.

> [1] https://lkml.kernel.org/r/20251216080128.42991-8-sj@kernel.org

[1] https://lore.kernel.org/damon/20260628085155.20828-1-aethernet65535@gmail.com

Best regards,
Rui Yan
