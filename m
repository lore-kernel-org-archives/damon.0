Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148901;
	b=pWeWbJB89sJlYueTeRWN7S9flcImwNYcVgdKfj0Zgq85OdPOf0FDZOgEohPRA0/NV1mP
	 blp/YY54+Nu5FeW58DxRP7F+Ssa9mYL1jPLkmvelXAJeTKFRfDleSzU0PlbJQtOBrfZEC
	 L70uBbfWkTelQ94cYY08aRbUaiK7xHfEudZj1Hij5eJjqcYNWImSIX5mRFI4fKqazhsSu
	 7EoVrB0z2qJSrMSgZV98kAoNlAJ8MJEYECXGPCTrreWkrPJq9ePmgCV+9BiwZCVXVQWcj
	 J/X6beFd3Dj04P3vCJ6+ggCn4Js0Z1bZZZgynCTHNlu1TRh5hq1ltd7D17DllJQcVqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4ZgROYSFX3uxrNR5jpP0XfaMHw/DaoPH2lgDKlwezuY=;
	b=r3pLlp+dk5ofepVlA1qRVfPb6xV/AmC5KjS723/oXLpOlro7RkgjfQ0WF5ftGtKJZEaG
	 H97ujJNEqYZM/Q86nWSiX1PCgxJ/EEEVXUh8Y7oBKz4yFuHXK3L2RYUVgB4VSO7sUTRKl
	 VNNuDJ5FgXMjmfIGJZMgeH7edlhE3+uKOUFddAylwVIl+IJRBCLUpnP1t3lKnPjTFSy3G
	 KJBsoDMbMOoNVQtQ77wCUhg+wKgg0iSSUHiGI0fSplD7im6qrlU5uXnftEzawu13S2ji6
	 wx2gWKdQsBwfAtFQsjVCWKWxYTbObfsmW5aSMOMcIAAQmw0SbYa3tEnX915/SydAFCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB3y2nsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8454606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 00:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB3y2nsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0496D1F01825;
	Wed, 28 Oct 2026 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148900;
	bh=4ZgROYSFX3uxrNR5jpP0XfaMHw/DaoPH2lgDKlwezuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iB3y2nsFBMKfAAVx/mDQIl6NqTb6vNM3Wtbs7LJ6JXVXIHixsjFy24NuALtMNEA78
	 RswEHWxDTSjCj6WcaaKlbRDyoBJV5eMAHIbYfUvKldVz5+B3vNtd1gsXGTb/Lvt7cR
	 +bq95bOiWJZ38nQSoH8qqkA0NDUCoaHuFP/SsL+gqEkmmI9/OggVa5UeCXomRA24G9
	 XH8P2uO/zy7NZsKblD+4lExNvMGoO1R6C4HouLVtnCH17Gl87e3W9OpHGlw4mJ1Hsf
	 p757BDd/K5HWCppehd5KakAhD01doOIQea7Wh6d2MANIXStfCVRH/vxKGtfltY1Wmp
	 rQGEza6WYsRag==
From: SJ Park <sj@kernel.org>
To: CharSyam <charsyam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	bijantabatab@micron.com,
	ravis.opensrc@micron.com,
	bijan311@gmail.com
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
Date: Tue, 27 Oct 2026 17:54:52 -0700
Message-ID: <20261028005452.157810-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMrLSE6ySuzsJJX-KXoeG49pS4ZVbNWZve1dwj1v1avAhHeEdQ@mail.gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently Bijan's micron email is no more working.  I added Bijan's gmail to
Cc list.

On Wed, 28 Oct 2026 08:57:06 +0900 CharSyam <charsyam@gmail.com> wrote:

> Hi, SJ.
> 
> Thanks for your reply.

You're welcome!

> 
> 1. I found this by code inspection, not from a real-world bug report.
> I consider it a correctness issue for valid inputs.

Thank you for clarifying.

> 2. I would prefer a u64 total over rejecting those inputs, since the
> interface does not document a limit on the sum of weights.

But I doubt the value of documenting it.  I wonder if real users will find the
behavior at all.  I think it would be not too late to consider documenting it
after we get an issue report from a real world user.

Even just keeping the current behavior looks not really bad to me, as long as
it is easy to test and only shoot the foot of users who didn't run test for
their weird inputs.  We can revisit after a real issue report is delivered.

What do you think?

> 3. Given the lack of a reported real-world impact, I do not think Cc:
> stable is needed.

Makes sense, I agree.

Please avoid top-posting [1] from the next time.

[1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying


Thanks,
SJ

[...]
