Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98793313532
	for <damon@lists.linux.dev>; Mon,  6 Apr 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775468477; cv=none; b=U/sJ2Jkc/i7+DDGcZJKAIWrclrHxGyFpzKblIxzXv4MZlIrjswO9Eu4BptPQ390JTnfABT5UX7HKUUf6YFNZbKU1UrEuXie2NMw+hK2o1DFy+nK+KjJP2/95K6olL9wKW+8oaFjEr0e2zgwzAfhKf52JyO9d9neNx1G7qp+Im5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775468477; c=relaxed/simple;
	bh=jtFBAO0leHL369VFxsKpps5hHrsy+AnnkYJ3meVX/Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRLy64bvzZJLtUa/4+f3BcCuWyeKYsa1PE+Nj/yZnLNUq1xB1nXsMSpa/OYW4GchoBnCBrK8lflzcbuXB3Tk3oSBsOVP4vSgneqMYknGfbbGKNxUldout4sQmxpACYsDz7F/3NOh1pKExQzj0vjH7LfP7nYXstITcMNbNo+7mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPxcyz9k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPxcyz9k"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2adbfab4501so13986195ad.2
        for <damon@lists.linux.dev>; Mon, 06 Apr 2026 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775468476; x=1776073276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naM+8vOUYX4BBsuu2hLmww3vg6bSX9RuihKL6tlmdKo=;
        b=TPxcyz9kACTJrij2ihO9cgout/2jyEGQVAuYC+LvtFd36TOFvLT+upmU+NaMQ40Ayb
         tYLb6Qywbbi5D0Ao4ZxTXaqDBspy+R0QLvd61Yo5mN1zDD8CJXV9DvLXqIN0h1umjY2I
         WptLXvATL1cQoWVZ68GY/n5cOrv8O93xQCzdVo9ec4RkYve6pQPBMLvPZtFPmlGn3jOk
         tQXaTcVtNejK9SPnTMIRp8XI1CYdYXoTG7aRSwTtnf992kK45eDvEmKtxiK1wHhGpAgT
         LNNm46jTopQ6teoBHk8YECYWXI1/kUBt/170LmAmlQox18+o/yIFsSysxIPNUwAwEbpw
         n3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775468476; x=1776073276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=naM+8vOUYX4BBsuu2hLmww3vg6bSX9RuihKL6tlmdKo=;
        b=Y1lUrG8b4C3YvxfSPEqaUodxy9UoBu5OrC0PZ2Bm+NvIaFnep6GeI/L91rNevjfMat
         zom7I1Q0ZzJYZoNmUXQf1BR9tsWJQZ9i7el43rl0yyygHMuSCfFoM1+ZT2mFW3OBbZfh
         7okePg9HKinHEvd+zwmx5GD/d2+Pmfta5rgI5oDvjjQHY7KGbYEhWSxX2Vc9eayZk5G+
         w2yNFvE+ffIIQXFpuxP5pL+Sl56VspdKfjHWbDdxGMvmGKTi0FaKL7qT69LYpY6BDA1X
         Sp1zyaiOMfFPos5x4fqQZAaqiPl3kUEdfRRH/oCl9Rt7+9LAxc7MecGGPtZRRES81f3t
         MKlA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wFkjQ0hjvqQGmlkHMey5rSmTRz02D3ZZ/JidDaQGprMD0/shcsN1UvQ9x7lJoTWpV4+zFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzezqUlcTwHkdMCgHi/P1zG+8QDBwo13sx9Z76Tn3qzyVAEUKPx
	w9nWOa9o6Zfe7WPAkB4pbHYD8FzaobU5eaqOd944DmMbbIW3isHLD9kIhEAUVg==
X-Gm-Gg: AeBDieu8Zi9XgnsIRZ4abaj+7sFqL4uZR+fA02LSTs3O1yRX3aWsSTlnERxaUFllNZ2
	OzUuzNls4BdOl6acwGTEfz5zQfV6ZbV95B+arMVdH17WV70mrZYx+dOczxGKH9jxRsQHHa0azYa
	rzt/3D+YIhWGqXeH27/ObBgozPkEcl3JvigNgYZIyQTBuZYKNeJKOmDcauSjDDXX7/B5dlqsTbv
	SAKsFEs+oLjeJGjw7JGQ8gSzinEN9IXdRxlcKSdH1bnNcQQ9NeyShexwkDhwzVBq8Ux9SXaplOs
	ZzWaQKXluF+E1YN1fGN0fwdTHY4bALAduR5+bs8z8khBr9i1YLkS+BFXbc8y9XpEnjeE1+AYs7q
	YBa0taVgvjdX7mOt0mwtnhseP7/I98lTr8UuIyI8qhjbmPloU4Bn82ZWTScDm/E0pEpNxNfH/ST
	1pceS0f4Qfe/L+mFlBpDYfwn4c89oxDLZli3U881Grr6tZlfTcgPU=
X-Received: by 2002:a17:903:1ae5:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b281927e08mr117023575ad.43.1775468475827;
        Mon, 06 Apr 2026 02:41:15 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477736dsm130327805ad.24.2026.04.06.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 02:41:15 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Mon,  6 Apr 2026 17:41:16 +0800
Message-ID: <20260406094116.13164-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404203044.86655-1-sj@kernel.org>
References: <20260404203044.86655-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  4 Apr 2026 13:30:43 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat,  4 Apr 2026 17:11:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > [...]
> > I think this deserves Cc stable@ because:
> > - The issue can be triggered by accidental user misconfiguration
> > - It causes kdamond termination and hard to recover/restart. Once
> >   triggered, kdamond remains in an unusable state, and I have not found
> >   a way to recover/restart it through the sysfs interface without a
> >   system reboot.
> > - The fix is small and low-risk
> > - It improves user experience on stable kernels
> 
> Thank you for elaborating this.  I now think this deserves Cc-ing stable@.

Thank you for agreeing to Cc stable@.

> Let's make sure the user impact is clearly documented on the commit message.
> Also, the code change itself and the current commit message is not clearly
> explaining how the real problem (DAMON cannot be restarted) can happen.  Please
> add the description in the next revision.

I will add an explanation of why DAMON cannot be restarted in the next
revision.

> [...]
> 
> > 
> > > For stable@ Cc-ing patches, more clearly describing the user impact would be
> > > nice, and helpful for judging if it deserves that.  Could you please elaborate?
> > 
> > I will add a "User Impact" section in v4's commit message:
> 
> Yes, please add this kind of message that make clear what is the user impact.
> 
> > 
> >     User Impact
> >     ===========
> >     Currently, if a user commit an invalid 'addr_unit', kdamond may
> >     terminate abruptly. Once terminated, it cannot be easily restarted
> >     via sysfs, pontentially requiring a system reboot to restore DAMON
> >     functionality. This patch prevent such termination by validating
> >     parameters (addr_unit and min_region_sz) early.
> 
> You mentioned it cannot be restarted above.  The above message sounds like
> there is a way to restart it via sysfs, though it is not easy.  Please make it
> clear and consistent.  As I also requested above, please add the internal
> mechanism of how that makes restart unable.  This itself doesn't explain it.

Thank you for your correction. I will make the description clear and
consistent, and also explain the internal mechanism 
(the 'maybe_corrupted' flag and why writing to 'enabled' cannot recover
it).

Note: 
Please excuse my slower responses in the coming weeks, as I have
upcoming exams. I will be most active and able to follow up during
weekend (Friday/Saturday).

Best regards,
Rui Yan
