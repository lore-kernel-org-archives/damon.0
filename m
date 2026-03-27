Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65A223DD6
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774590657; cv=none; b=YoUPEPxzY27MqIGkdqkZcjedTcbNrj2MTTdMNTdBGqTs/UyqhoNKL/+p5HoJEv4NrqnkEqZVCC9G5OnLqM7Za/35MlFh8/ba/iqRVSc8YWwnL2PvHDOe8BPjZ5tfx83ORbpQNfC9nYfxfIsISCwe+eIXLCEDyrsf2cH7Zb7FLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774590657; c=relaxed/simple;
	bh=ZS1Pe+c1r7TqFdFAZpTqrQF95aQsrOC5iHLl3NTRxnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwhE+jVXClifQQmld8xTEnLWfEBqNEcZjs7KaPR0KMBeRa+8xoQWfgqOw8/h1H6p73P1sFk+EDjH1Ng38JHpbmf232EtX1pLMXvL+Bfd/Oz/s6PsKZaYZkf+p8OKzaMWYi6bcGcNND2/iIqqVgPcs77ce826LsWzQFzaIIISFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT3K860y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT3K860y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab46931cf1so21048385ad.0
        for <damon@lists.linux.dev>; Thu, 26 Mar 2026 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774590655; x=1775195455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QKYZHcQVRzoD3H+dvFRXjD92ZagIwWgZbCKAQDMQpc=;
        b=jT3K860yDznq+aInH3J+EI8BcT/YR8AOi/Mop4O9vA9PAYXzgcI1EVgBmf2Zcsb9nV
         kKkJBDlMXW3fnd/AS8lGv0E1TN/BFLv3Np6nLirSYg3XfmBkxGFgESiKsFv3Et6DJTfu
         aEyODERJxNyDddugwJeCnu38Kf7f5RUQPke6o691T99hqnqFJxbQZgXfQdibjUkV4uQp
         WH+yapTTQ2oDwxme2HWNzzvSZqKotO3q0NorwH1Mxj7irFZM4ehyhhsNv1+OTaj+9f8e
         4r3laB6loo+xWOrM2UojA1pFDtSTzA44ySVX9gsgAbooJ7AXwHh/vPLGGxqmD3XJdJX+
         fybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774590655; x=1775195455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QKYZHcQVRzoD3H+dvFRXjD92ZagIwWgZbCKAQDMQpc=;
        b=WehrFsRRklVA0qx4vA2Giro7QAhvtWaPIazSvxzYHbyp8ylW2mMwDw3dkXZbDU2QSx
         5jP4HWq8Rf8gp1hBZ2S1YcbK5m5EPlqsH12uiG/dELseVwFGe2l+8scnfgqx/ao71A7T
         wl0JKgEoOt6SNz0riGnHQ4o4U0WU77zBy2+IsxBRucorizTSyNAeGYwhgYuYyYYi1lJr
         NJTCL94oQvuETdbdeiR4Vxd1sWkZ546USXmBimvFN8GdJwuvsFgVSmGdSTCbxH+V9m4r
         OGoZKDFUHr6oVXb8yPPPQtj5W9Y54L6tBvs2JFrhtKudL4GSdJ4YQZs3h6GPRUJQ1hKG
         nylg==
X-Forwarded-Encrypted: i=1; AJvYcCUqiAtV4/xO0cGwxnnmaYfrWy5e236eHSWmTsT/+6WZ6JxoxwglT4ugj/AZ9qpceyjJYP+O9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOy3J/8SjzDslNie3j52bdJmvZh/RTL/xSYR7XUWuyDF1hA1vg
	ysWsEGvklSun+6BxuALGsVq/0wvR41GK3N2zHP/+PY2LB6wvhz5fTgkEMDSzTQ==
X-Gm-Gg: ATEYQzyCV04ee4TK4Izj13VLShPKVIn8ILKGqPxiTeyK7ThXLtAX0i9KAN4wsb1th1P
	4Bi40uLMBqaGJOqcUEJ/hQvOGKl+02JJ+t05UZk88MyYL+20yWTCvZz6D94T4RmMK5cwEoPmDhZ
	cqSR4T1yPPAKIPR+s6FR+jA+WQFAVgdz654iEKlg8GsubhV9f0NEaayxHeOnlvXDy9Nelr60qMr
	ywNpRnM7HBq7KvSGlT4WgJSFQ5hcaEJcVlWvVPnEtRPtPNztrf3lpDY3N341LrMtslFhG5w/sx/
	IWmL1XexwsajxetFUp7dPSPqLGU+ompR0mO4UUg6FCYZ4od1NqT6k1SaAsoT2VlPsOAZiJys/Zh
	nbAIcCPDyH+9avQoJRp/8NO0vT2D5c0Z7Qnm15SwAjk47Nw+Gki3thgw76v9I5O74LshlwqlFGb
	foNYobXzyRlboBQp3mjh40Y9+rmJs=
X-Received: by 2002:a17:902:cf03:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2b0ce4ee4c8mr10673135ad.9.1774590655239;
        Thu, 26 Mar 2026 22:50:55 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc916b73sm59918045ad.83.2026.03.26.22.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 22:50:54 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Fri, 27 Mar 2026 13:50:51 +0800
Message-ID: <20260327055051.61731-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327050823.43382-1-sj@kernel.org>
References: <20260327050823.43382-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Thu, 26 Mar 2026 22:08:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> [...]
> > > > I will add a patch in v6 to validate 'addr_unit' in addr_unit_store() to
> > > > reject non-power-of-2 inputs immediately.
> > > 
> > > That's because kdamond_fn() has recently changed to exit the loop if
> > > damon_commit_ctx() fails in the loop for any reason.  Refer to commit
> > > 26f775a054c3 ("mm/damon/core: avoid use of half-online-committed context") for
> > > more details.
> > > 
> > > Adding the validation in addr_unit_store() would work, but it could be a kind
> > > of whack-a-mole game.  I'd prefer doing the validation of all inputs in one
> > > place, just before the last damon_commit_ctx() call.  DAMON_SYSFS is doing so,
> > > by making a test context and try committing user input to the test context
> > > before doing that to the running context.  How about doing so here, too?
> > 
> > Thank you for the suggestion. I have now added the check
> > '!src->addr_unit || ! is_power_of_2(src->addr_unit)' to
> > damon_commit_ctx().
> 
> No, what I'm suggesting is not adding more checks, but reusing the existing
> checks in damon_commit_ctx().

I just realized my previous reply might have caused a small
misunderstanding. My intention was not to _add_ a new check, but to
_move_ the validation to damon_commit_ctx(). So that patch will only
modify damon_commit_ctx().

> 
> And, now I think bit differently.  Given the purpose of this patch is making
> commit_inputs synchronous, I think making more complete validation check is
> somewhat that can be done separately.  So my suggestion now is just keeping
> this part just as is.

Understood. I will keep this series focused on making 'commit_inputs'
synchronous, and prepare the validation for 'addr_unit' as a separate
patch later. Thanks for helping me scope this properly.

> [...]
> > > So the issue already exists.  But let's ensure the fix is merged before this
> > > patch, since this patch adds another exploitable path that can consequence in
> > > whole param_lock deadlock.
> > 
> > Should I wait for your fix to be merged into damon/next before I post
> > the next version?
> 
> As long as you agree about the mainline merge order, I think you don't need to
> wait for my fix.  Please feel free to post next version.
> 
> FYI, the latest version of my fix is available [1] on the mailing list.
> 
> [1] https://lore.kernel.org/20260327004952.58266-1-sj@kernel.org

Thank you for your confirmation, and your fix. :>

Best regards,
Rui Yan

[...]
