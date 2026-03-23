Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D497823DD;
	Mon, 23 Mar 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274876; cv=none; b=DBfr31tRwAH26U0zdgDr9fm5QN7lxofMQ1wEq43wZnIle1lyI9CxFr0Br1bRZKLeHLmkimy+RTQRNNZstUz1foRe0OHuk8WGSZHGZfwMDzduFknMmDyhsCTqV7hLJHWbKHV0spncLYAHz/G/YLLtNgqKQw7wPDzyKY6JElbGTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274876; c=relaxed/simple;
	bh=1PaO+4+rWONsxrlOsGWVrD/qF2EGfVXjIo64l+ZCULY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rg4LvP3IEqXncD1cpXHBu/7ko9JVu0dETTKs3xCSY24OWCqPiMvT/Qiit7aWz09X97cD8hiZPGsphIrq6TcZ+qOB8y5C3etFueTN0NSMtztUxc7cCj/XXH3qNSpx33XA1V0BLYNTM90ShS3HXA+AUrqOjY4PloWqQpOW8jczUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1iSyCwv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1iSyCwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E9C4CEF7;
	Mon, 23 Mar 2026 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274876;
	bh=1PaO+4+rWONsxrlOsGWVrD/qF2EGfVXjIo64l+ZCULY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1iSyCwv4RPHMa9bKPi7CKWFOdHrI4g48+418mqXCrBCwAUFlzO/OgqIgoybsxZEn
	 z6A6sAbxjs4kP8KVTZpQ79j5neOnJgBWeM0bF5WxVTWBl3wQCd9D0nJx3Vpa7CEKXc
	 jjoGlAHHMSlOaySIU54LPJbLXDDCJHkeNYTLNTkP/vFq3lh1VPxHUV1BXc6wmoCYaZ
	 Ms9UOqI9aLlr3GGyX1MZN3pF8TMW28406AXQG2OfP+z96rwVvZr8yHvOiJGCog26wl
	 WB1YH745EVFt65ULXLaWPnADtcoVImT4j0ZeyD2gueXsC+ZMEIKToCDJVNt2CwLlKR
	 D2K4en1d1ahHQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme and region loops
Date: Mon, 23 Mar 2026 07:07:48 -0700
Message-ID: <20260323140748.80083-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322214325.260007-2-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I show you posted a new version [1] of this patch, so I'm skipping this.

[1] https://lore.kernel.org/20260322225627.263202-1-objecting@objecting.org


Thanks,
SJ

[...]
