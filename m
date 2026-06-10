Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB73D8128
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102498; cv=pass; b=ZOApTezK2W7htKGATc0KXU+zTKjmBS6TSNQ859PMgMBGeFrDzhyYnj91s20S0v8Y3W8tOZm2S5lRyrotJG3enMrXIHts0Sd3FWCa2tbERh+0PcvZO/vWODyDDEFzPrjGRfEozEt0d3dG1QwiZowm64vx0IsnTQdBX+NpDshqc6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102498; c=relaxed/simple;
	bh=J3ECnoRaw03PN8SDn4t5pTOE7Fjc8A5WosNk33q0VdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVuZ5iovgqJkLETYxftADx+YTofMJxFt+WFJOSsKtUzis67oQVT/On9JRGfYILiPQ6WuKCZWXFWrdi74WNSF+DLuiBHLbeXWDti0IkOV2h4pH5YesII0S79/hHHLbpmB/QAY4lxZqRpaPPl6bdqhFerlIno2jPmBikkEt56JldY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s18gBfcT; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s18gBfcT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7efc32aa7f4so4952297b3.1
        for <damon@lists.linux.dev>; Wed, 10 Jun 2026 07:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102497; cv=none;
        d=google.com; s=arc-20240605;
        b=HzrHchuwlXYF/2UM48n1ZX/N1YywTDQxshAfN2XRXsyt4IWLYCKRxJjdKLv4XoH4N5
         uA0GaSvtyrTp4P9M7fpepAcehe4D/gEDMzB+JAJn5+O6IsaVcPH7UwjGcHEU6Vulcbi/
         z/uAii0p6iTbS3sXgWH7rP3FNhWcjRF9tcBcxFreSpUsglqAn/wAblpmCf8zTu6xWOEJ
         7X3brl7Ex3Ekh3TUWlb9u6GJQvW+yRBhJmwRFzSKGGArJrobRcmh6amWRDbeIux0HSaM
         loxpXRpBsnrX+GOO4ciohqh1hnhJTZ3Z148b5QcRYmL8RVqVkNpADoe+0H+2jxzspVfg
         UQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J3ECnoRaw03PN8SDn4t5pTOE7Fjc8A5WosNk33q0VdQ=;
        fh=KiG+e38ARZOt4tMXa0S2cwy2UcYZUqmHPA6nVGZVRVQ=;
        b=QvFidOAY4ccwftpEuUtAJ/xi484i3ELQHhR03E7dd0UDtM/kGEhakNypFxT0J4lRb1
         /y/QQba3pbWzYSAk7c9SGxrMOY1BdFgy+2mrFaz4aH/p72wNvJX62etQvgX3eMGF2KSb
         fRhmhJ1NbsiG9NzW+I+93GsS2aOMioyN/AsZdQDXooIh6Jl6xeRYbhptWCspbpY0RCRs
         OamXv0WHHaa+Nj0FOSIE6clkfwfih0zt5nBmliLxdFMHTmBgP+rCqauLJrCgSReoLsnh
         lShBISQWE3IKJK/qfWpiG3VI+3urpqlQNW8C8mwKnEVfV91V4v3nnannLcbUvuJG7cCC
         g3EA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102497; x=1781707297; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3ECnoRaw03PN8SDn4t5pTOE7Fjc8A5WosNk33q0VdQ=;
        b=s18gBfcTpIovoOG7BovpwL0ynvjRBTEfDS/QKHGOK4f3sHVp4RWbqGlrR+LNTpM/tf
         Xc7ZL6oIfAZ926AXQGA2TnrG1KWV0tLLUq7WJUI+rpZZY905egVQSJ0gGwGrcsZvjy5h
         yHGJHeW8M6Ive/l3SW/dDPYYiyW515qOuPOrcKQajd43uat7IBpFYe2NhmWXL9a4bMbc
         s4XiXx86oHKnwpT5V70stu/Go6gUoId6/iCLt6MqGaiCXO7mJVn4uom/FbKHfzvy8prY
         qXT5IRsPe4/0CMkf81HpoDD7JXoMaC8XqAKf2suCjct+gOU5ox1fGgKkdgesVlXlk9y0
         NYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102497; x=1781707297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3ECnoRaw03PN8SDn4t5pTOE7Fjc8A5WosNk33q0VdQ=;
        b=ZBVWIZhHxvGfEsqTRpdyEs8/pGIWr5e/yzJ4K/dF9virs/30ZphsdIoKCFFS84tTIg
         io7D4I7uKHIYkgIYQMsKHw+2Es1XbKhq8R/iDa7gk505bZzlRDCAh8hUqJ1/QJQr0mZg
         YIjLlxAwcNN212RvHiOEzls9rdYZu2pbuAIKRX1/q5z08SQEYakDvI4MzXlNWCgHGCQy
         ZoMBqBnoCNqLpFnZJ0s+OS2XlwDv4yIFev2e6fQY/rnZ8TnBIqO4f0zZwNuBA6+hvaSn
         /WVOOHG95VcaUFIXuQvUL9EfR7XfeJaVXWtVc2QkQ22YruCFc1zos2tluYMpBOYaan0t
         pwJw==
X-Forwarded-Encrypted: i=1; AFNElJ9soxbHG6Uj7c1F0xDewXdeVdkPlFN4gpaw5KMWJNQ8Vf6vzZAzwBpzzMwW6U0nF8Y4TbFefQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnXIp4Sr50f/T08rEuSZEuQiRahEYmxnUW9kq77Hru4MgWgpfI
	Ku4mNteMjFFdjXxErtUQ2cwVMS6lKSlcEzNazDBYsNor1JMKtoA4JkcoDh/GC9UPbxCR7gvXpUv
	mnLlPB8h+j6nmF13EAgZ5oRRf839BBWM=
X-Gm-Gg: Acq92OG4AC9/UataMu+uDO5S8Fvmr2YXyfWnQr0J8RKdsO39d3mzlIt09EKbY5zKdBe
	XKNr+R229I8FKHP3Qtpg6Oz991ynYsC6LfuS/+xMj7a1D0yVL7nikDRWTIgqtnWck9KSHSXh9nd
	HRFr5PjlUE+l2WPmNDqsMOcYnrxt9N5v1Kz+pA8+cMItIxeSCmdF3Po4sxs5WJ+DKvIfVmhNhuw
	5ztbNh1m9x4LkWcxe1fpVpFzsqfjupKmXNb7CCPZIoNth8YFUd767ScD2XsbG1lE0quzvpeJ5R4
	DFX5H1AcOV1DyHUXphXAlBIA4KAWq2WhLwnKKCOydwkpygWSQEziyHt3o7lE8nXV5widtB9vDFG
	ja+KSUbk=
X-Received: by 2002:a05:690c:c510:b0:7ba:d784:8b59 with SMTP id
 00721157ae682-7f2b24517e2mr46666727b3.7.1781102496564; Wed, 10 Jun 2026
 07:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610053951.553739-1-doehyunbaek@gmail.com> <20260610140217.65110-1-sj@kernel.org>
In-Reply-To: <20260610140217.65110-1-sj@kernel.org>
From: Doehyun Baek <doehyunbaek@gmail.com>
Date: Wed, 10 Jun 2026 16:41:00 +0200
X-Gm-Features: AVVi8CfkGlQtzkdy7N4hrt8LYt2S_-OHJvl9Twtw0u9LuNxesLYSD1U1AF8K38Y
Message-ID: <CAN-j9Upu0grcp=AL42m8b41GCnU3+CUYJbj9=dg1esUAJ0hguA@mail.gmail.com>
Subject: Re: [PATCH v5] Docs/{admin-guide,mm}/damon: fix DAMON documentation details
To: SeongJae Park <sj@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Let me know if you think this is really urgent or I'm missing something, though.

Thanks for reviewing and applying it to damon/next.

It is not urgent from my side. I needed the English documentation fix as
a base for the Chinese translation patches.

Dongliang, would it be okay for me to send the Chinese translation
patches based on damon/next, or should I wait until the English fix is
picked up by mm.git or mainline?

Thanks,
Doehyun
