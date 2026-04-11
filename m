Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8174414
	for <damon@lists.linux.dev>; Sat, 11 Apr 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865896; cv=none; b=cglXVKg10napZTxg31WTxFed59fMYxoEvWxJDjM5evKxhIRsGllwsp20ilBPNJcx0CFh73XtEMUuTXwuA+ycLZukPb00aCzRLN5YAQSnjhrI9phiw0TZUS/YhaoH29YTplPO0mhIPFsLI1fnusc/8zPs+SdPw/r1o+2MNcXO9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865896; c=relaxed/simple;
	bh=Qxb78j/xqCnIttW1i+35Hr6POwW0wuWCsNTEUDMMdRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQXayJveakYbkZUpX5SVQm7RHroBjsTFT9A58w9gKe8Hm3B3cDytkZMskRR81/9BSkFQ32AiALiaIV+sKap2ZaJG/DtCe5xpkPwXMpHGAHg9jsTAlQRtJj7ZksJCEm0GsEyODdr+dXePJU9cfOEt2zWlpRtdrVmnfQ7baAHUy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgQKG21k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgQKG21k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b299b3c739so11922335ad.3
        for <damon@lists.linux.dev>; Fri, 10 Apr 2026 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775865895; x=1776470695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSfSExwzC5aExbWCOmuuVkACJaQn7xM5T6CtW6BGQtE=;
        b=MgQKG21k0IIYuLPGNGanr4rOA6KGcB2neTY/EiE4uLO/rkrm8cb6FACho1n1l7Wa51
         yHp8ToSlib3cXjaOSuFfjAQSV7uW9QaPk0jqwCxwGZpeWgEL2ipxqXzU8Ho3HNJMXRys
         OmZX6nNng6c5SbmUgxILl+a+HPjjQU3ghaSta0f9GU96u+taIimYPPr7qXUK/wc2LGBB
         RA3wywmkWAeBa1G1z4RO4gLFO/dFquPVp2GRNTvrA/jJUAt8KeKyKzL3TRjBRAGuL88j
         qvxXWcQPUko9NU2/Q0mr7Oulpo8HL6NSvjO0+Bl51PPE7qvqzcAvW5PAI4Y+GzqWZG14
         F6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865895; x=1776470695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSfSExwzC5aExbWCOmuuVkACJaQn7xM5T6CtW6BGQtE=;
        b=SeHReVYljli3YzsUJEsZxTLEKjRgQiBkk24VLX1UBmOrgPGsh/o+waOL+S8c2/s6um
         Q3l1caI7Q6oJj/87FX5TqQtqEITcCncjnfVoI3ORB+gvkbUgXEOLgxRRDskCkfF4J+pS
         lIECqf/gFKG8fp7wf+4WstaN+4UCxiK7dK9NbYjWR8kCk2ZeltZQIWRtLDgNLXz9yC5e
         oefdXupjmxYCMpjZbuaTvLMrLVOuK3qkgF8CdC0MdJSxTRS9ab3/g/MqKLpB62Zj5Rvd
         42OTnHlvyJ05P2k3DooJE4eSKP5Ue7TCgzBNbsVqdjdTtR9fLnlunH8nwS8k8xGXUtin
         O+MA==
X-Forwarded-Encrypted: i=1; AJvYcCX43E5wZSpNNbRGHQA6BeJH1yuoermzGaOTW6SDBbAP3fxAbh/jG/PvCNdVIIPjxmcXSKG28Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzwq8OKF4w5l1FTLpta9ATzdePLRthGjn3F4VbL/Rg77K20vSYg
	qZMH4Wj4o7C9c3siaH5fGn9+4kWCPymMDH90GjYwvZ+uoAufxRMmFfpf
X-Gm-Gg: AeBDiesAr2MWB0eBS3V3XBmxoa7vQekgZ3mFx6J1R1bKBSSnU1KoF2S9ZYGML+O8p9l
	mOVYE2RXyeebOCz2N8Jb7+VCLFrVeZl6GkrVPX758pu6gO0zJv9Rxy4G8jPySCTKh92+WfsoJNC
	IgSEaZFSuaOg2TImCudOwqofaYdtlEBdBalrS7HreMsElApQEBOf7xV7zcPDrNG801r7Fh0mKqT
	kjFFQTduqx2SNbUpJJog16b8gogogi1/aILizGAgXytoaxMP5f1s/ilKn0N784SPCbS1V8p4eb3
	QCEq8DGuF31n0he1SjK4WvICUl1Z1okDbAmEV7lKzjoV75XvSgVwdr5xQ0EGTj9n4pFCCJi9MSw
	K1NgK8l/4LNYoij8Honx8hAL5lYpyVK8QIB0b8a8PtrrttkpdIdCMhJWImkuUXpCNAUaV3LVVMI
	yiw5TQBpjMliXy4Q2fAF/ced5ZAiqUgDy/hrIVx8vAiH6SV0u0TQ==
X-Received: by 2002:a17:903:350b:b0:2b0:5694:7b62 with SMTP id d9443c01a7336-2b2d5a78d4fmr59281715ad.44.1775865894667;
        Fri, 10 Apr 2026 17:04:54 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2001:f40:906:1c06:7a81:226b:e033:d971])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd610esm41422265ad.20.2026.04.10.17.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:04:54 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sat, 11 Apr 2026 08:04:58 +0800
Message-ID: <20260411000458.11479-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170051.51008-1-sj@kernel.org>
References: <20260410170051.51008-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Apr 2026 10:00:50 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 11 Apr 2026 00:46:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Fri, 10 Apr 2026 06:55:00 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Fri, 10 Apr 2026 17:40:04 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > [...]
> > > 
> > > Agreed.  This was unclear to me in previous disucssions, though.  I still agree
> > > it is out of the scope of this patch.  But now I think we need to let users
> > > force-restart.  Adding this to my todo list.
> > 
> > Just to make sure - is this the same issue that my recent RFC patch [1]
> > aims to address? I want to make sure we're not duplicating efforts.
> 
> Hmm, this makes me confused about how we ended up working on this series, then.
> 
> > 
> > I'm still actively working on that patch, and I plan to send the next
> > version next week. I've been holding off because I didn't want to send
> > multiple patches in parallel.
> 
> Ok, seems I dropped a ball.  I was working like AI bot that only works with
> limited and nearly fresh context for each mail that on my inbox.  I will work
> on making another thing for tracking this kind of parallel works with good
> context.  But since I already dropped the ball for this, I'd like to make sure
> we are on the same page.  So I'd suggest below.
> 
> 1. Let's hold this patch series.  Andrew, please don't merge this for now until
>    this discussion is completed.
> 2. Please summarize your parallel works in progress with the context about how
>    you decided to do that in the way, with summaries of our previous
>    discussions.
> 
> Could you please do those, Liew?

TL;DR - There is no dependency between my parallel (2) works. I never
intended to merge these two works into a single series because they
address the problem at different level.

Yes, here is the summary of my parallel works and how I decided to
structure them.

My current parallel works
=========================
Series A - min_region_sz power-of-2 validation (this patch)
- Status: You gave Reviewed-by, asked Andrew to merge.
- Scope: Small, standalone fix for specific issue.
- Dependency: None

Series B - reset parameters (enabled/kdamond_pid) on unexpected
termination (RFC [1])
- Status: Preparing V2.
- Scope: Reset 'enabled' and 'kdamond_pid' when kdamond terminated
  unexpectedly.
- Dependency: None

Summary of Series B
===================
The design evolved through our discussion:
1. Extended 'struct damon_ctx' with 'thread_status' pointers
   - SJ pointed out: "This feels too much extension of core API for a
     problem that can more simply be fixed."

2. Alternative proposals discussed:
   - Option 1: Termination callback in core API (Too heavy for backport)
   - Option 2: Override '.get' operator for parameters (code duplication)
   - Option 3: On-demamd correction in enabled_store() (passive)

3. Final direction comfirmed:
   - SJ suggested: "Can't we catch damon_commit_ctx() failure from the
     calling place?"
   - We agreed: Simple, backportable fix is the priority.
   - Decision: Reset 'enabled' and 'kdamond_pid' immediately when
     damon_commit_ctx() fails, add a fallback in the damon_turn() 'N'
     path.

[1] https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com

Best regards,
Rui Yan
