Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36A4E1CF;
	Sun, 12 May 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715543045; cv=none; b=SHieIfVvgZREoc05zUvkflgW69ubfkVtcdsgVuff1CN/BmZyYtIhU8TBjza9v4oWmnMX65F4gPUJHPjOjQcQRvZniPk53byhZiaaYPDXO51cTpki20KL7wgR3GYk5O6DkQB/N9+N6rePSEan5mzYJ4lh2YCMDG3L7prCqBgnz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715543045; c=relaxed/simple;
	bh=8DZqDhFgKbpGvB+c60lvPF2j608LiGdXKkx2a2gA8ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYTDzAZ5ZMnplWH4yn7L6bh4nB+6M+GIHot4YYbdBSR8HWNywP2VIWpZKOr2gk1s9nndCOQ+xYzJ1tPoEhwBbNY6Z1LgduL5UJLmcZam2Q1yBd03dhK8ljSLPV5E+tE8DB9w6vi7Hpm14BReIAVmwtVIq0MK2qLFv7flykWPKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rffXAPYk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rffXAPYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45316C116B1;
	Sun, 12 May 2024 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715543045;
	bh=8DZqDhFgKbpGvB+c60lvPF2j608LiGdXKkx2a2gA8ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rffXAPYkvmKwRHy8bNAJjwdI3hx23etZb8xBObuihpiCOKiDl4TmJ/IbNgBX8zw+s
	 3I7WHApi1weEHdI5j3N3nAc1Evs+AyqiECF8MHTWiok1a0kzE+LAmlkPgJ5CrZGGwa
	 /H3X+AnsDSjyzzUf323162S6lBlrzvMgrjzqvzANkyTt6y5TEnbmg/f5JA7pbSBdpC
	 vi0RbnoonPWkYuiMJxn8q+VGs2i8/FGoDIntlL6Qq+e9zrxQwMMUt+gcvGL9lWOqge
	 qA7McimJYjeI0VOcaqJsxYrZLan4Fy3c29ALce/sPa9Al/gUlXimmAlIeyfD1orOMX
	 5G+CuvvYYGyXQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Automation of DAMON tuning, tiering, and VM guest scaling
Date: Sun, 12 May 2024 12:44:01 -0700
Message-Id: <20240512194401.79396-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129204749.68549-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 12:47:49 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> Thanks to the discussions and feedback that we received last year from the
> LSF/MM/BPF 2023's DAMON updates and future plans session[1], DAMON made many
> advances and yet more future plans.  I'd like to again share/discuss the
> followup changes and status we made so far after the last year's session, and
> the future development plans on LSF/MM/BPF 2024.
> 
> A few topics would be shared, including below.
>
[...]
>
> Access/Contiguity-aware Memory Auto-scaling
> -------------------------------------------
> 
> This is a new idea which was not discussed in last year's LSF/MM/BPF.  The main
> purpose is to implement an access-aware, efficient, reliable, and simple to use
> memory over-subscribed VM guest kernels.  Specifically, it will steal guest
> memory based on access patterns in a contiguity-aware manner and report those
> to the host as free to use.  The PSI-based stealing aggressiveness auto-tuning
> may be used.  It will also apply a 'struct page' overhead reduction mechanism
> to the stolen memory.  We're currently thinking about memory hotplugging and
> vmemmap remapping as candidate mechanisms.  For simple usage, the interface
> will be similar to that of virtio-balloon, which is widely adopted.  The first
> version of the more detailed idea[7] has been shared before.
> 
> Because it is still at a pure idea level, not much progress until LSF/MM/BPF is
> expected.  This item would be primarily for the future plans part.  That said,
> at least a second version of the design will be shared before.  Also hopefully
> early proof-of-concepts level implementation or some test results will be
> shared.  Since this is expected to be more for future plans than status update,
> I hope to have more discussions for getting design level concerns and possible
> collaboration chances.

I just posted the RFC IDEA v2 of this with pseudo-code level implementation
example: https://lore.kernel.org/all/20240512193657.79298-1-sj@kernel.org/

Hopefully it will help the idea success or fail faster :)


Thanks,
SJ

[...]
