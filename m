Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7CD28EA4D;
	Thu,  3 Jul 2025 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520514; cv=none; b=b8f5Y2ABsQ87WN+VEmmvLkSJ8T1JLTEdSzv8RKH4a6rCI18buNnLExtGY8ZQf3OWNaQzYCPZQXpnNqDgX9ddP8Edl6R8eQlzyNCoaqFwp05vuzbZGCwo8TPDQLfODwfTpmy2G6mC2XD/l/Du/SeVOArJfOSEkOKZw/chJeSkK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520514; c=relaxed/simple;
	bh=5tLCkmTWSmAOMPRYGBW/tP4yMqa+RmtgXftKpMpI9l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBEnKDEoW/7MrDc0n+v2JUlXIaDZ9K5/BWFPtZUbSaYL9VTi29qmsIhn1tpotDqqCldF+7DLgw8BfZaLlhtiBmZr1lwuLF2HVNJ62oAHtjadsDGCnJckdpp8ErbzmfRGEbxpS2y5qcLPLjir5hN73INFEnOu3jwoL0wPcmvyC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI9Zq1IZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI9Zq1IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D60DC4CEE3;
	Thu,  3 Jul 2025 05:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751520513;
	bh=5tLCkmTWSmAOMPRYGBW/tP4yMqa+RmtgXftKpMpI9l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GI9Zq1IZo/VnkSPu/v9k/Lw+yeS8o6igRnmxmLWaXambJwSosvDsfhpJDipYF1Tsf
	 mL5QG5ypsY3vLmHjiC6yg4erM88R3jh0bpD2FcIe/0enUXNSZHCuLqwFS7CFWPgoUi
	 jnjzHWRPYu7T3XrsBedKO10nTfXn1wJ9NI3TPtK/Ero2Fhbk+at9tVV82haF/duj5+
	 EwSVGB9p/V3HkLf5QCT4y7nfxRxlScb9P7OfC7/QuSejbo1umZ7xUoWtHKvtNSDz4d
	 3KRSxeZPdIewGe6jOzthWNw5IKy6u65fSo4htQNApNc/6DfL1iNk16gzVy9uQpEDJY
	 1h0i9uC0sD1PA==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 2/2] samples/damon: add `migrate_hot` and `migrate_cold` knobs
Date: Wed,  2 Jul 2025 22:28:31 -0700
Message-Id: <20250703052831.39709-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703051836.1759-2-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  3 Jul 2025 14:18:34 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hello SeongJae,
> 
> On Tue,  1 Jul 2025 17:08:25 -0700 SeongJae Park <sj@kernel.org> wrote:
> > Hello Yunjeong,
> > 
> > On Tue,  1 Jul 2025 17:54:17 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
[...]
> > Because mtier is a sample code, I think it's primary goal is to help developers
> > know how they can use DAMON API functions for writing kernel code that is
> > required for a situation similar to the sample.  Hence the sample should be
> > clean and simple enough to be understood.
> 
> Thanks for explanation. I understand the intention of mtier module.
> As you mentioned, mtier is helpful for leraning how to configure and 
> run DAMON.

Glad to hear this sample is working for the intended goal!

[...]
> > But, I feel like this change is rather making code too longer and complicated.
> > Hence I would suggest dropping this patch if you agree.  Please let me know if
> > you have different opinions, or I'm missing something.
> > 
> 
> Ok, I will drop this patch in next version RFC. As you mentiond, mtier
> module should be simple and intuitive enough. I will consider this
> kind of tiering module to mm/damon. I'll send you RFC v2 soon.

Thank you for kindly accepting my suggestion.  Looking forward to the next
patches!


Thanks,
SJ

[...]
