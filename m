Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D1149E13;
	Thu,  2 Jan 2025 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735790987; cv=none; b=LScQWZ90g4VXtEJO/wA5BHNmueXHU2TrAS7H1Vofnd72LYqzxL1zKYk6rU0gzdGNEQLW6bsewz94ZvbFZPJMwMLV+kwlVBxrdq7+otAfDpPlGnSh34uYg5B0+eXhMSQoZHnCG7mTT320/gV+Eh65FXgat3f35cKADYq+tNK/tFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735790987; c=relaxed/simple;
	bh=Cguc/Vy3Znk7hHXGwu6SI7c5KaM6bds6V/2OpFFLWUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3hLPIiypmzEHHp9oFQ0RpXGSEJBE7KslInk3ZhqM+Sgxq2k0fWDwIuYh2mKzsOXjIWH3W2yvY1ThTRABSTYeotqMR0IAUa0cWfP27Kq9q9O1yRfl9ginZfTKp3X0Crvlp4+lheukS2uLzvUZQOE4/Y0KJ8nYEKkDCfACI0T9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bv7nd5BL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bv7nd5BL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=myzmwxDcINypq563XOfWi61s0whZewbz6J757QkJqaE=; b=Bv7nd5BLgMle4jAkJs/01Xqprr
	HeF/WQcOV7PWsG308/Ln5q6vX2Gaff5cjcGNT1eCZQec3AEaV9EmtOlz2QpJH6hQcaibLrlSPFH61
	FGzlESSDqC31JfkSRhaySpnqZfaFeNYX/7H1roPQ/GsZbExvAihN/rnhXGuWVVoHhAFRtbZOqpmWv
	rZJiFWWzhEEkeD6qr/OBIfEQ/SgLxuDHXQdg9Qoa1+5MaLbY/8wvsEdhNaexrK4DvHY9elh+VzxDH
	DfsgqNRQoQ78Cb+l2h9DlNGUJ2LzVG+1DtMkbRH8/qJC2Zbd0f0YY+POp1VUu/yHnmVbhAbVOHrE0
	GytdQ0Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tTCWg-0000000EyqQ-3M4n;
	Thu, 02 Jan 2025 04:09:38 +0000
Date: Thu, 2 Jan 2025 04:09:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of
 Future
Message-ID: <Z3YRggwxMQTxfQ4k@casper.infradead.org>
References: <20250101222039.74565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101222039.74565-1-sj@kernel.org>

On Wed, Jan 01, 2025 at 02:20:39PM -0800, SeongJae Park wrote:
> Hi all,
> 
> 
> I find a few interesting and promising projects that aim to do efficient access
> pattern-aware memory management of near future, including below (alphabetically
> sorted).
> 
> - CXL hotness monitoring unit
>   (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)
> - Memory tiering fainess by per-cgroup control of promotion and demotion
>   (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
> - Promotion of unmapped page cache folios
>   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)

I'm not sure how DAMON can help with this one.  As I understand DAMON,
it monitors accesses to user addresses.  This patchset is trying to solve
the problem for file pages which aren't mapped to userspace at all.
ie only accessed through read() and write().
