Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3A2741A0
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057508; cv=none; b=A4oRwLcDCQKCw6AE7rPyp8DL8AeHbn385dRReu/vqR6omvwbtL8cS/MgIvl89BYNXfU8R6OjHEFhXKQ6HY3zYMX7c1Zkld87q8VpzuFAz+Y33t8Vd2S+Qmbt7o8z54EMPiEqTVM58fHw9PtZ+pJ7C8l9pYPZRInTIy9HrjVn4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057508; c=relaxed/simple;
	bh=o+X/UpULPauJmbUmMn0NcofFdnbXOdBoW6xeYvzSfH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGo9OSHUKUn4/3aj0GHlgQHxz3koEF+aObEeWdeHNeLBRhvp8i4e3tTx/ejE2h+b1kZzY43tSvUrFOJomnyNSDDanTohbvv9bjp4fqEbrxbhIqzqAh0FpAH4ZN51k23ae4zBIhnIaeZX7itlr2pYL2g2uea3aGo+egTN8CSdP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+La/TOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+La/TOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA898C4CEF7;
	Wed,  1 Apr 2026 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775057508;
	bh=o+X/UpULPauJmbUmMn0NcofFdnbXOdBoW6xeYvzSfH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+La/TOm1FMdV52EzdorO7pP6ryywcpltXbYeDY9anbRQsc4hqJ2CXu/U+2WM8MQY
	 m4ADwOI6nBGC7QAmHrjxSDerhTLVHqzJAk6wfIQ72LqDpYHWIKk8oEIpGvu9u7xtPi
	 j36l5DWhFRBTqMsB6toA2NxWD55eiQUZ4nZJg6lXAtOByj1PhK6HZmJ3BgVwYF239H
	 YeZxspMQK/t35pzkRZG1zRVZsgRHgJsJY4QqRoSCXDgSX3PZn+CXoWi05WADwOC25p
	 x3B2rh5WWvtiirPrzo5mcnLwb5PPmf+eUFuC79lDWXOyyUGiDo0zb/EWqgNU4YEgKa
	 wRr7BmCGx6evA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate min_region_size to be power of 2
Date: Wed,  1 Apr 2026 08:31:46 -0700
Message-ID: <20260401153146.67711-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401084045.15473-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  1 Apr 2026 16:40:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Tue, 31 Mar 2026 18:01:56 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 31 Mar 2026 15:32:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > >
> > > [...]
> > Seems sashiko found an issue, and you are preparing the next revision, right?
> > Assuming so, I will skip code review of this version.
> 
> Yes, I'm preparing the next revision.
> 
> > > 
> > > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > > ---
> > 
> > Weren't there previous versions of this patch?  Could you please add changelog
> > here, from the next version?
> 
> Thank you for reminding me. I will add a changelog at the comment area,
> and add this to the commit messages.
> 
>     This patch is a follow-up to the discussion in [1], where we agreed
>     that the validation should be done on min_region_sz rather than
>     addr_unit.
> 
>     [1] https://lore.kernel.org/20260330233343.4083-1-sj@kernel.org

Sounds good.  I appreciate your continued grateful contributions to DAMON,
Liew.


Thanks,
SJ

[...]
