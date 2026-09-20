Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3543CE4D
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907111; cv=none; b=uWCdeg1UfUAE1vm9QpplkyPPiCnCph0Plqm0umX2k9igJ4h9DMdkueXqqMZgQmZkdbKpVNYfmV5IF+E4pAPcmm1mLa9Ka89wq190dtUCcm8tEDc3Eo2GVj7IC2kiKl3RrfiCaaUWoNcfww7JA9Gm0raK0bFIq/VTuepMsY5EMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907111; c=relaxed/simple;
	bh=m55ogdFoo0Jzv0GB82m+XB58M8rKI8owtLrio9jl438=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzBgtwaIiQzvGOdmfoaOJv/mBMHup17E1p5nsWrSoF8kvAFjRHlR7H9cZPRw863Bh77hx0hulS2eHpX4EvaTp9VUkUjCUss69kk+5XBYS/OEd48DZF+aC/CXCrfPJD5JeS3OfdZdXLq5s8ymd+Z4StDDS12iNHRdoow8py1jNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyWinWfS; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyWinWfS"
Received: by mail-pz2-f27.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so1431584a12.3
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907080; x=1790511880; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InRkxGfoq1s0w/ybf166NOP+zAmO71hub0jrhGTfC6U=;
        b=GyWinWfSOhCDE/5ivtlsGw9xVfaIoPIoxWFJT19OhdQ3F27ch6s0lN1Udnq4BWqOiH
         wNmjUTkaQjeAlGdOSfwahspVm4iRvOA2UQsoXifDh00sDN4/10H2aHMJVK589mWLy48J
         1rapdFLAE8NJ9Fp0YJEDuR+Z06bOFFUlGsd4T8P5oKasAgNiaikLsC9dUQAZ1xF+fA3G
         GdYnFdCexbuxkRDXJ0hLx3v5jmGGZ2726UKAU8eoeSEx0wuxQV2Pirbu6lxGJg0Znq9w
         4y8YiyYdb7pdjvFYUUn41Dy4eyzVPe9r+f4HBtCkoRxTA4hcsB7TTOsCV5Yy2olFkL8Y
         F4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907080; x=1790511880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InRkxGfoq1s0w/ybf166NOP+zAmO71hub0jrhGTfC6U=;
        b=nyjmT6Ruf5YYu3Zf0XknEqMBQ4MunmgR/dWaQYVBs30KnaJJZw9vmtw7FsmkUZyguZ
         6YGk244rnG1lCm++jc3SoKp2LAV6kCfz8YxxRfV2JDfBuXRcDGvkl/74JxNn0yrcgTk2
         bvpvRZLkG6NJ9sT1UYm5XRLOmE8Iwl5tFtHl5AYnQMz2bD0nwmuKvkLdVHxEdpq0Edfd
         Rsun1uiHhaQnBvjKKZAuxXKCPpXiN91w2W50NRHINenZ4WFraWlQOsqzV1SR4HLFbZRf
         hNDvePIB7OrhkoBWlPHlAfXmsbh/fMZbxGIlMHHUX6tmFcpol1vGsJeu0pzUd3rYQJD6
         2EGQ==
X-Gm-Message-State: AFuF++kF0BLD9dUHBxR3vWQAPeiaYBe6KlU9xelPT8YTWK61vk7ig4ne
	F1jztYQ5obNzXR0s383Op3qFt7odaZn40qgAeftxvmnFv489+3Tr8zQ=
X-Gm-Gg: AYBFou3lk4vWLdojvWY3b3MZqqst5QnxGQA9rhdHiKpadQlT2e9UG87VIscuzogT4nC
	uRy9TEhOaqxRGrtTeCB68aKk7e9/eT/KVcui5+dj+uJ0GlCswzlRZDo+EIMAu69uexmPmE7adcp
	o49NdsZ14JF6gGlzBJiXp/TdbQU7h/8OINWNpGFhNba3mwjcNDozPO/ksNtQ6QABjIuGVlhutil
	6s6Xq+RV832wgrT1OEH3DoyFW+YJZDAqbAyHLnea9mZO2bksNhn7Kg+8ug+Vj0e0brI3xbzqs4B
	BhWEg/jHKAxwUoX/HUaBwssiCHed/q5Ev3vOOchK0A/EDDvBt4/aFlIBer1bAcx51JXLwQWScYB
	Iqi0QTQa04XmX2iuUmg0E+K5Zuh0WVMoMX0v3wb9gA3IkQQ4wrxTrY0/6N4gxtlGuO3kxDmpDJe
	1VGjPaQwHNGqlTqfWNEmscvRfgyykBApe3Lp9JKC/mXyBEHph/SLQlr8seLG6yHaRuvYl1hsNE4
	KZyuhD0/MLeVbMYGEOwKnsj/NQM
X-Received: by 2002:a17:90b:1e42:b0:3a0:345a:3620 with SMTP id 98e67ed59e1d1-3a0345a48a4mr2499091a91.45.1789907080513;
        Sun, 20 Sep 2026 05:24:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5647c151sm4972754a91.4.2026.09.20.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:40 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v2 2/3] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sun, 20 Sep 2026 21:24:36 +0900
Message-ID: <20260920122436.610279-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920104054.47877-1-sj@kernel.org>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com> <20260920023111.2466265-3-donggeunyoo.kernel@gmail.com> <20260920104054.47877-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review.

On Sun, 20 Sep 2026 03:40:53 -0700 SJ Park <sj@kernel.org> wrote:
> Please wrap commit message lines with 72 columns limit.

Done in v3.

> Other than the above column limit,
>
> Reviewed-by: SJ Park <sj@kernel.org>

Thanks, added.  The code is unchanged in v3.

Thanks,
Donggeun
