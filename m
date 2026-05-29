Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E23F58C5
	for <damon@lists.linux.dev>; Fri, 29 May 2026 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086600; cv=pass; b=tcLVrnjHMnB420OXJk45YIFMP4exsRJs7v71kpMqWH/SFZXYrVaxTYWy8GK+8Xve7QJt7dEHSsigFPpdgslz9gHwuWDn1HZB7cNyZbZWEwjc/IlEY5FRNkSpbxmhA41BU2uzjUybAO+DlRzRWdsUVv90HlvU3abbrUs08cCiST0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086600; c=relaxed/simple;
	bh=wRm0Mrq4p/xpAUriVMRT8KHk0YOsp6bKZfV+5HD0Cyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so4vCRTfskCx/czM6yPLiimtZUc7N+TZPZo9///C7aH2wPNz19G3A1v7Zwg7cnVhRrS7LB8A7O8VUw7Id+cjAozmc7uwWJYM67u4/HbNX1o8+Mu35+Ohun6ecWSqosfoDjomFHEBs8Rq48NZdZ5tAQhfd7+D+b+NPAbm62Ejcsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+mGveOE; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+mGveOE"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bda62f13d90so1595864566b.2
        for <damon@lists.linux.dev>; Fri, 29 May 2026 13:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780086596; cv=none;
        d=google.com; s=arc-20240605;
        b=lrqZKNfGHD/ak02rbt7o0Z5jv1KIE8ixlHXyNzJguIFzNV5nnXpzG/Kr5c7NzEfItn
         2oViwo+cmwiTOWtXo6bYyNYoBD02utJNlN622CwZg4tmaeAIUOtNh99xX6f18y3g4E9r
         StNNVHTMZdBZX/1QJRJgjD//beSz9bFnw88RhWizXFVwCsKZEAlnT4yWGUkLq5VJeeBR
         q0sOc0W0FzXzlCdR0bVspsdfOFjrdnCU/1DQYu9g4Sv/Upvv8VuDF/EF05lMAlgroupZ
         EFDODXcP2thcsi7pGlI5BJR73W1TL1ZrrHbswdK3JQQ08lfUgWDnX3Irle3DBnmbJ+5U
         F/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KBAL2YVoeAsOB80jhdCnQFZpr0bN7/PSE/KDx/NE2YA=;
        fh=a6BiU+7jW9hoz6/9rdWAFsp/aU3eMIiJSHMxIh6cpTY=;
        b=jL9+V8G+PdiGcvU3L4i7v0y0pLVEmyFp4WGYtnokUc1Us5j1qRud6638gScpwua9oW
         jP1kOoXSiI8D4bMSAdvXDwIdCAEufsdDTIEO3WSmjd+xxc8GkPuZpAysTK4n1Rw4yOOO
         Cqn7WZUkTXS07LU1TYSV4+mntCMABYnzyKW1EEe7akSAwTbUuV6CsSXl/pUnaBAZIrYt
         9vPvvPMKrZfS1Eb501GJ3AnNTYNqlBSERIBK2XwRihQD0hTenT3b1gTpM1d7CouaSqil
         dknT4c9T+wbrUJPIRF82nu1m/kXVABhjhbI5mEMRiWPwx7DMK8qnODXSUWYUjsyunt9N
         AKnw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780086596; x=1780691396; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBAL2YVoeAsOB80jhdCnQFZpr0bN7/PSE/KDx/NE2YA=;
        b=K+mGveOEEXd5GLXCAVWy+Qj7yFNzfi5kS4fHABNI8TR+4oBtM1XdS1u+gG2Ya/uGh3
         rhRjf28wxFeqvEBE2s6BgGVBvA9Rx4D+6mzrZBtOe0L4AB6KMdakFAaxMGiltQAZKQXH
         99Gkzvy/BOsRfJP3hMYeZImioahagHP8z2dqj7EVpXcQxUmcPdklGBSCJ9SCoNJdy2jp
         bVTltXaVphfeMSdWMsKMFAuj73YDhcxVLrkNFA854IUIRRzzx0G6gn8XhbyS94iwUPDP
         5LjEvqcGjbuyj1sNeSkGkP+pnK050lmJJJA+qoEfGmn05a07KUowMwQ8cD86hpMatr/Y
         urFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086596; x=1780691396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBAL2YVoeAsOB80jhdCnQFZpr0bN7/PSE/KDx/NE2YA=;
        b=p4pjKrs5KQCaQSO2PVn6eI34ZD3scQehbrAY09q/y0lJwac/Blqgb67prQvhsw7IrR
         oNV4e7r3iF2fBjQkC74NpJeBNQ/UXNAg5r+0osrGKGeByWLldVNnbC6FXBgehBAEH7EY
         vK3kSj398S1s7mMWnJF+NA/Sl5razKSKp3XjVGCdC9z3CQky3ID7TxNP3/EY8j0Wdc1d
         Ukh4vTJefo7/avfuqYEFRyJkXmGOII830uUjt+L8Aspepeb8ZGxsiHQ5g1GYvi4dbiV9
         OOQvweLHJ1WtA7/efMzFDJ6iDpvMve9PHorgDFZTIbhx0Wh6f7tZtuTuf57XChnKB/ua
         nohQ==
X-Forwarded-Encrypted: i=1; AFNElJ8N8kOnhPpa/2R77f+UwBAdMPUdo/OpjRKbtcfPH8z/U3vHJrsVOKLlYNcPvOVtLFFX9Tqt4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz93ZCResbMsjW8h7CpDxBOEwVqvTLTm6HTnDvcSnEQrKRXOpC
	7RyNCPlC3zmGCH3m1r18mb8W5ClxMbfUF4CsbwnOfTyn7pA8WCchjwiEQL+7T5dlWeBce9oIQ8Q
	O2FfZ7bm7DAULWcbnMag9WMFUPc4KKPU=
X-Gm-Gg: Acq92OH5I7e51Xoliv0Rp+vcw/N0MbBRtPdeM1xjHrcuSNJ8VvjYaIzPELCgA7tqPz6
	NpSAjSD4pd+ZKI/d7draT3EyXQJ91AnAlLmxSvrmi4qALe4PUusTSRv89m5x0BFqHw/6h6kEUzg
	EpZtEa8WZWWZComX4mWg+Y9CG/i1my/tW4WuOexqphKDfXpR4YhDLxVJaLco0DcrY1VDW0WlVlL
	Zll4brI9EreZTdu4zSDtqstkOSuTU5+nK1bIgogetxhJlXkeTaO0edoxMpl2+MivdbhGUBaP7id
	wrLT6tDDKOktpFNfxxs=
X-Received: by 2002:a17:906:ef02:b0:bdc:55dc:dd85 with SMTP id
 a640c23a62f3a-beab4f1fc2bmr62775066b.28.1780086595591; Fri, 29 May 2026
 13:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACrCO_XCxTDk7b8wo66CrxzfOXG50-uCxdE9tjJppH_ei5Wo+A@mail.gmail.com>
 <20260529160030.85303-1-sj@kernel.org>
In-Reply-To: <20260529160030.85303-1-sj@kernel.org>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Fri, 29 May 2026 16:29:44 -0400
X-Gm-Features: AVHnY4K69zftCKA-7FXWI8bWbXBL2Ryf49rMdHcUkPQJ7C34OBdd6g5bxd0ugg4
Message-ID: <CACrCO_Xend-ivqq6TZ3GDhfTm-JsyoYJQjgNa5pdeU+5sFwKrg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/damon/stat: roll back context on damon_call() failure
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 May 2026 at 12:00, SeongJae Park <sj@kernel.org> wrote:

> Thank you for clarifying, Yuho.  I think the current cleanup is ok, but I
> understand it is confusing to read.  Apparently that confused you at least, and
> that's not ok.  What about adding a comment explaining the context?

Thank you for the explanation.

That makes sense. Looking again, I noticed the same retry-time cleanup
pattern is also used in lru_sort.c and reclaim.c, so the behavior
seems intentional.

I'll send v2 patch adding a comment explaining deferred cleanup and
retry-time handling.

Best,
Yuho
