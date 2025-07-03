Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B513AA3E;
	Thu,  3 Jul 2025 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520279; cv=none; b=tyiqLGAz4OBsxAjzivSAqXeWo6CFEmzT14KsI1zRpZrBqbOi2z3og5SrvhN3Om2OtKLuPnKRs9z+rrAQL52AZub/6OI1JT1/r+hetvf2Tw1zmY1JCpojH1kMar/XiZtu5WR0q1+mdjwjNsN97vuwDOFx7EFmuak202kYhU6hbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520279; c=relaxed/simple;
	bh=ZLIWmnaB/4VL4QjgzSpWp4WX95XD/DjC3uUTSgVtLKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6NOzx77iOKZRFFGueLtQztpsntsQnnJiSO68Sdcgi0BJEiCT29YNggR/znga20lJ5QvNFVbkBKF32Z3K2Uu3zSSeg0S7kyxhd3ugVpcsIn3pQjhPs7NkgkZlwcck8bW9CNy+elmhP9iDyrybDtbbu763006X2+KaI63b5IB6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK+y1WY4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK+y1WY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB464C4CEE3;
	Thu,  3 Jul 2025 05:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751520278;
	bh=ZLIWmnaB/4VL4QjgzSpWp4WX95XD/DjC3uUTSgVtLKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TK+y1WY4lU3p4ObjZgA3R6/OR/o9crmVjL5fE6b4uRHdsCYfrQTy3aZB9CcdLrYAV
	 GgFPx2T3jITaGToOnJsIUvDA28qcPXAwM1GnPyNcCOrA1F0l73RC5hnXKZVpsK+nas
	 zKCJ2wGvGs3u0mP71uFDz4sNs4dd793zaxWVay5PFHj8y5NEnqaIiZDKxWt+SUhxzE
	 N8vWqBBby47vuzdKnqpTTm1+7fynyBL9lNhNLMB0t82k6iJjAaacWJrJDqoN9BP2uq
	 Gr4msvh2tnh9NQ7LdVN6AVuuJxxjSWhM037BOFWoPLultcsRdAw/H2BYPV+uKF+z3V
	 vp1XZOsGUtsOw==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 1/2] samples/damon: convert node id to physical address
Date: Wed,  2 Jul 2025 22:24:36 -0700
Message-Id: <20250703052436.39603-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703051836.1759-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  3 Jul 2025 14:18:33 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hi Seongjae, thanks for your review :)

My pleasure! :)

> 
> On Tue,  1 Jul 2025 16:54:07 -0700 SeongJae Park <sj@kernel.org> wrote:
> > Hi Yunjeong,
> > 
> > On Tue,  1 Jul 2025 17:54:16 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > > This patch removes the `node#_start_addr` and `node#_end_addr` knobs,
> > > and introduces logic for converting numa node id to physical address.
> > > It only checks whether a numa node is online and calculates the
> > > start and end addresses of the node. It does not verify whether each
> > > memory block within the numa node is `usable` or part of `System RAM`,
> > > as performed by `damo` [1],[2].
> > 
> > This is just a sample module, but I'd like to avoid making unnecessary
> > user-breaking changes.  How about keeping the existing knobs but adding yet
> > another knob for the automatic detection, say, 'detect_node_addresses'?
> > 
> 
> I agree. From my understanding, 'detect_node_addresses' can be set to 
> either 'Y' or 'N'. If it is set to 'Y', mtier converts node0 and node1
> to their physical addresses internally. If it is set to 'N', it uses
> the existing knobs. Is that correct? 

Yes, you're correctly understanding my suggestion.

[...]
> Thanks for your detailed reviw! Next time, I will make sure to check 
> checkpatch.pl:)

Looking forward to your next patches!  Fyi, I use 'hkml patch format', which
automatically runs[1] checkpatch.pl and misc checks for common mistakes.

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#checker-run


Thanks,
SJ

[...]
