Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5838836C;
	Fri,  9 Oct 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531976; cv=none; b=mt0VzD9PtlLAxZNqU2ARf3REtUD0ihJ14yj0Q0ltQt/3Cp5ZbCQMo5tBFoCzb1NQLzId+ODVL1O1vu73gByqE4yzpKs0wrUSqnEbVHxeWV8z3XR/aPZifm+00T21Uc0ZZ1KblZpFfv4CTCUBLlX3rZEcax/Pu4MCUAx5M7RKjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531976; c=relaxed/simple;
	bh=wZv8TbBp1Y6GzSkuwSZImYDggbd85GwINuhGYKZX2bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOFOERIBbA7mZQD2tiYd0mm/0oH7gdWzrsADiGgAVkHz9HKq7hwZw2FsqPmIScSiMPo1NQUxmrbH3OwgBgb1VrkfqP0RjqvPIqlJP9DxLjgU9wcoMYenvLjSyq8AHAlF0+OlwKfvr+2hhtDmkpo1y5ZGmQTkPk0ZagBjV/ADABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxOKpDs4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxOKpDs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCDB1F000FF;
	Fri,  9 Oct 2026 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531975;
	bh=v6z02uFgszMrykfA+H9Lp9iL6Wt8zF9IJww9x8UauC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxOKpDs4KsGTOWH08PpkeJrjcTh98rZoJrZqvjkYBmeSULddDTjFYd+6/ktBJfDlw
	 KhAAdp+9TWemJ7qVAj2WLf2JCrCVLJ3MzJFSgscZGL33vTFBmYafaq5AOKpKLE6jMk
	 U0xcHPbo8ho9M+eRkw1LVBPSx+Z6CDsxYYDz4Bs4DTo0tmp+IFUZ8lABKU7lVjEwFN
	 AciVb8xjvVPJlW7efCXAr12cG7HfN9pZM9Q8t+JQdiWMqtt0tHp0Erj8iUj3RI8zTr
	 NZIE6NUMTmy3MsiB20dS8LDPw+JotggZp6Pqh0/wUlpBqaNS+nfMm4K/7Ueig8At1w
	 C433LXcVW8yIQ==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Fri,  9 Oct 2026 00:46:10 -0700
Message-ID: <20261009074611.40973-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ase2u791QTcV1LZt@fedora>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Oct 2026 21:03:15 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> For some inexplicable reason, the cover-letter hasn't been sent again.
> 
> I am just adding the changelog here, in case the cover letter never arrives.
> 
> Changelog v1->v2:
> 
> 1. Simplified patch 1's commit message to make it clearer 
>    (Liew's suggestion)
> 2. Added comment docs for extra arguments I am adding to functions
>    (SJ's suggestion)
> 3. Destroyed the context in case r2 allocation fails in damon_test_merge_two()
>    (Sashiko/Liew/SJ suggestion)
> 4. Wrapped lines at 80 characters 
>    (SJ's suggestion)
> 
> As for why the cover-letter isn't being sent, I have no idea. Everything seems
> fine during `git send-email --dry-run`. Also seemed fine when I sent the series
> to myself as a test.
> Apologies for the inconvenience. I will make sure I fix this issue before sending
> v3 or any more series in the future.

No worries.  Thank you for clarifying this!  Maybe a possible workaround is
sending only cover letter first, confirming it is sent and appear on the
mailing list, and then sending patches using 'git send-email --in-reply-to'?


Thanks,
SJ

[...]
