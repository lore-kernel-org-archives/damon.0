Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621661;
	b=YbpEnEImDaEmEvsYxMCpKmJrPqpafQdt1muy/HdRN8cS3o94+Shlw9HwG5Cjb9UEfHKg
	 EfR6DxzCBRkafa4xc7xSOUWJbntAQzKEk7YBWJXuE2sfR1bj2cVcvwAlv9dpnmh6Bae5i
	 3T0rTJz1tlnM1zc4EpowgQP6XytpYUijELH8VZvWPxfZP2d3oPCyR/jePUMG/5V0bTozC
	 JVOKbh4l8up/OVtvu98+NTyD5XwG/9514807AKqRu+xbK6KrIs78XfyIIDtbQywW4Edfa
	 cGzgDh3feD2T9V7eFdYb6M9Sf7BwOaudDCZUEo2pSW0CndyHZNQqOGR5TqXI4LM2HqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tMxB3nJHm4VLSpjaUX4N0sdRzUI9Yhm8pI2/MBZa7yk=;
	b=XQCM73T38HfdDtF4KE84BMJpSfCYDCdSvP96PymoCbNI358UXQkl0JHSk5dGnCFEXSsN
	 52n3mXc+T9EiE4tahIiAmrZdSUSmUq+ueFu5pGlM9WifV2jlQQZH1wHl7bKcd8xiuIeSR
	 xoC9EM4dDS5sNn71QCMGj+92Ed3H86Du6LvqG/RglSB5apHtj/aGW4byZ/FoUkMMWcFIR
	 RkHE4ip7KusPvIVeoBNUa4GYc+n6XGZH5iJUgUMBMDu5MOZ7GT1d9vxuAmQkuwBoNeimX
	 PysXNrPEIDb8IdmJUiW5lMhsxy+VsxyVunx+MHLNj8oxQD9FnxeJ7jiXWlM7AjdFPvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEhnhCZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E73606A89F;
	Sat, 14 Nov 2026 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEhnhCZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F181F000CA;
	Sat, 14 Nov 2026 02:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794621661;
	bh=tMxB3nJHm4VLSpjaUX4N0sdRzUI9Yhm8pI2/MBZa7yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEhnhCZEUhjHhknFxhwKV2eoFSVSyYSiMZKGShHkzTiulwCmnS1kEb6Nu/09kzht/
	 OhmVffjz+iYVo90Gp1a09mvNY9Q8ajZn0nJSfRqVWG+aNZ7oRg4x6rbF1gyS/zYw04
	 gIXS32eSkn36BEq0bWCBJ96iL2HH4FXr+VSX8NJHqjcC/+t518aGAohh4Nk52PGQNE
	 aamfuNIDW5Niqpp8hs30FoDhK9t6HOUYKXj1yZNy33hwNpOZC8iC8Krf59NLof6kNO
	 lvlYyYjvZyOc0eDAem1rz82NXW+0p0rZ18mzDQNvfuRKXCucrzUYitAiTGrsKcIL1+
	 ktiggl+92bKyA==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
Date: Fri, 13 Nov 2026 18:00:52 -0800
Message-ID: <20261114020053.109570-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113-test-age-ms-filter-v1-1-b99eab2f71bb@ucla.edu>
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

On Fri, 13 Nov 2026 07:58:55 -0800 Jason Angelov <jasonangelov@ucla.edu> wrote:

> add kunit tests that commit DAMOS core filter type
> DAMOS_FILTER_TYPE_AGE_MS.

s/add/Add/ ?

> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Other than the above,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
