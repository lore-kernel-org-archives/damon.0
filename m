Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0292293B5F;
	Sun, 28 Jun 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665430; cv=none; b=XXoVlU+AnUrLZK8QfzEp7+FRzAs0hLqIRI72B7y53/yO8N8F9Ds6qk2GCp6CKIi9rF6+YIfuqwk/IfInb3PtOVtSslTW0UOzQfTVKv82wMo6R6Khe35jlSGPHCesGm7c7TrieIsEbuAsovIVXqGasgnXGVbHxAMB3NEH+6zHvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665430; c=relaxed/simple;
	bh=EQFc6WIkd2y+a5dZpYrFuSXzwXemq0x5CnxJSS631pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNbX7sZCuC2DgEXRBOjp4V9ju0kBCIznWmTtr5oMDFFX1/Ytb0eb+YY/tF7hVgA3ZRB61YHLwQL9pmEBCvpQDSVlIpAl2nEJU30u3YftJ+HE+uXFw+u07l6Yf3Q3Me2POHWNiNzS4eosRYUH/vNAPJqO9oI/vjzGUHOyvJkgz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqE78tfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqE78tfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD681F000E9;
	Sun, 28 Jun 2026 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665429;
	bh=4tNWb0g/fFPdngLw0tQabxt79dLq+ueJy5cbexUblyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqE78tfjm25WDHjpzvrUDuASfQ6RRBt6XmsrhSHc2ipd0VA/+OiPFBeE/vPDD4nhJ
	 DKdBQVZOU9pgmzEEj2SOammBx39+0Xfn3enODddgHhenBIMmQhaOesQQjnCPvnG2hd
	 Ap51hzwMwf125cxQSSdYFEWCmrUbbv87L6k2gvoUIytUoefawvO6QTpqM2JDvMHdL/
	 SFXpWUHJv8eHULhLUtq9aZhcwsqQKyjnFd0EDyFeOyrdcIBvaqgazf24VVtAH0tcAz
	 8xuSk80DH5Vr92CeP9a8QBaCj4VRiR8afNvJD6kSuJldAdX4UayAPFHMb13EFEQnwG
	 QmOXDp68rg0ew==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: reduce kernel stack usage
Date: Sun, 28 Jun 2026 09:50:20 -0700
Message-ID: <20260628165021.85893-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627223405.3533412b4010b6ce658da01f@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 22:34:05 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 11 Jun 2026 06:56:07 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Thu, 11 Jun 2026 14:56:57 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
[...]
> > Should we add Fixes: and Cc: stable@ too?  This function was introduced by
> > commit f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning") which
> > was merged into 6.15.
> 
> I don't think so - kernel is full of these offenders and it will be a
> long and painstaking process to weed them out.

Thank you for input, Andrew.  I agree.


Thanks,
SJ

Sent using hkml (https://github.com/sjp38/hackermail)
