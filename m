Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FE31618B;
	Tue,  1 Sep 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223246; cv=none; b=ePib9awng7+aqpROqEeZcdQToAFRaO7y0Uj0+ztx/E4C6NsKU4ad2G7JBX2EMIg+FrLPcFpK1LQMSjj/eFUBYVb7+9xKPJk2om1ibrPJVWN3P2Rl4Rc4H/eCJThDKbxWYvokVaLwLc1Lm2kH5KTIwjx0VsFgkvRqLT352pEKuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223246; c=relaxed/simple;
	bh=PK2n7vZOrhTsUmnMH3JvGIHgCFecO12vOBVtt6/xpEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgs86NrVVRSr31RZAs8wr8SgeQyjoFu2cRGhvnBxB00Gq7+HE9mS28t3kAIp2jXF6aOzCtuG/XjZzopkfGHlHJw0WFbmvqzZI4KM0W7NNX4A9WT7J91MZkuy+gIvgXKrFH0PZRuguBvwaFO3k9MvOnUB/UtF2jp0zWibRdedeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSpqM4kT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSpqM4kT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7228B1F000E9;
	Tue,  1 Sep 2026 00:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223244;
	bh=3N8NIqIOxkcYSjk247eYz7rQGp0XJk93W3Myu5nHrNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSpqM4kTqw0jxKwvfK9n3dBnjAL8wdD5lAfrynrfZMtQdgiocvvGTm2AnKUmjRmzP
	 hM+b/68DxI64UeXiepXd5zilqWLAcsS0ezVmCahaBG42SEUD+7v2ut23iudRjIGxcO
	 yOkPj/u62Tnv2q+4r9fz/lZNxMCy5VfdlTYcMkqNBAVElYFX/pILLvqy6Q3/mlEaxK
	 DpHXzTYN10PlSfrYZ9FCL6FhAzYsOpeFNgL2K6f7G73aDZgY2WOjqiIwqTk+f8NuUW
	 wPFpvgGtndbxU6q2ctNNXs0GlobJ+Ph+hpsXl+0+ErZaTHZBY3KTVyjeMNg/DLylaK
	 oXzAUe85DsQkw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH 2/7] mm/damon/core: introduce damon_set_target_pid()
Date: Mon, 31 Aug 2026 17:40:32 -0700
Message-ID: <20260901004032.89105-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831163119.66bcfdd8a4ee66b3609be63a@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 16:31:19 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 31 Aug 2026 07:26:04 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > The logic that finds the struct pid for a given pid number and assigns
> > it to a damon_target is duplicated in multiple places.  Including
> > damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
> > of the two sample modules, samples/damon/wsse.c and
> > samples/damon/prcl.c.  Add a function that does the work, and replace
> > the duplicated code in the places with calls to the function.
> > 
> > Signed-off-by: Enze Li <lienze@kylinos.cn>
> > Reviewed-by: SJ Park <sj@kernel.org>
> > Signed-off-by: SJ Park <sj@kernel.org>
> 
> I assumed that From:Enze was intended here.

You're correct Andrew.  I found you already fixed this when applying this to
mm-new.  Appreciate!


Thanks,
SJ
