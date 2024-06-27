Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1619754D;
	Thu, 27 Jun 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506008; cv=none; b=bnqrXcAt0ysNUJwu3S1hksM5vVAvqsTf48gXRXV8RTfJSWnbnSngJEV2Q7JzElpoo8R+lCmPtV2vJNQJMfBVnKN3/k66CHwSqbxjH8IILGZoKLqRZLZSNefWFYkn4yH4S62YUc++oP7WF2NCZ57zmqEnWXMmbRnTWeDub49QoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506008; c=relaxed/simple;
	bh=2DUeWGEU+EJlfVkYq57q0DvvAe6Il1OLdqPN8k+FcWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2t1ZJeANfsQnbZjU0zpZZnaRnrsCX3FZe1SRv3pUgd1T1xKKr4AloNhlM6fADUSXaLbjM2yP8VsC9NkJaRz89L8lfT4XIKHDp4quLgeI6EOBartm0nNvW0zbKa19+uU/oIV4YqZd5W4M3yqyBxUnxA8e6BJ3Bgnr5vM/LokdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtwt8xMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtwt8xMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F78C2BBFC;
	Thu, 27 Jun 2024 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719506007;
	bh=2DUeWGEU+EJlfVkYq57q0DvvAe6Il1OLdqPN8k+FcWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jtwt8xMJ6A6/JaQGJORqQg54gjxEyxEyuC3q+BoF7eZ3+KfC0oXv7YLAqOddbtb9X
	 4J6Oz40bvv3QEAd3bpR+3bfqd2UkB04vNKAmT+AQr8bFYLaLtTZErzLBpocxX7qP2i
	 zp/cO07mztDg/+tedme4sfk07Zkj0VK7cb0eDMS/sv5FpYzEVzWNG9Yf8JdcPEOX3B
	 zh4hFWgasgYu+8gaz3VIHmvw3rVzaTNIiEab6mEj11l5okiWBdXmMW3NF13/kGf18O
	 BlId1jmvejfykSlZI3Ay07mX5r7Pg0M5NnAZLpL3UwKIswq2gzB1lZdsANUlum9J/f
	 YNVdovoaxbQCg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] mm/damon/core: increase regions merge aggressiveness while respecting min_nr_regions
Date: Thu, 27 Jun 2024 09:33:25 -0700
Message-Id: <20240627163325.75996-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626150516.fb14ba5e65ae9d59ece0d390@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Wed, 26 Jun 2024 15:05:16 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 26 Jun 2024 14:49:54 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
[...]
> > I'll send the fix of the fix as a formal patch soon.
> > 
> > FYI, the original fix is definitely better to be merged in stable kernels, but
> > not urgent in my opinion, since the problematic case is not common and the
> > behavior was same since the beginning of DAMON.  Andrew, if you feel the
> > original fix is not stable yet, please feel free to delay moving it to
> > hotfix-stable for one week or two.
> 
> That's fine - we can merge cc:stable patches any time, really - they
> will still get backported.  There's only a hurry to get fixes merged up
> if they're security-related or if the issue is causing people problems.
> 
> In this case I'll await your -fix-2.patch and we can merge the patch
> next week.

All sounds good, thank you Andrew!  I just posted the -fix-2.patch:
https://lore.kernel.org/20240627163153.75969-1-sj@kernel.org


Thanks,
SJ
