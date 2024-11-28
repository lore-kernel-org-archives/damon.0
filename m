Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F5288DB
	for <damon@lists.linux.dev>; Thu, 28 Nov 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787652; cv=none; b=BfaTqyDWcxMX41cqZ6XAwXtipfMFHsxuGCa1U7RwDi1X2SIZYO/rfG/yIy0fNVcQb2CVmDAIB0slwBNh8O7UtOYMJIJiO0ZHJsfRBSzfF+E4jonQir4d5PwMs8rf+xD2Mu3TMzhn3rOJatM9TCYCCVCes6JRMnRDWv+IQ+sVpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787652; c=relaxed/simple;
	bh=eQh2pWC0+7ytTEqQK2XrIe6JfItAAMbL1y2MxiKihmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsQkd4QMx8MWgtXeg1lU8cZNBLTWGpMFkPSdfJLvU2iacL3uuVyUexiOZToS2FcgR8SkJDeV4WzYA8zjY/cOFx3gt83IcnviVc4/hC2wI12Cge8IM/dutSXR3uwpEIy90VBnkt/TkZ+EAJlQg6trufvv6cFZCK8nZLESpd8gzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-17-67483db703ab
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Thu, 28 Nov 2024 18:53:55 +0900
Message-ID: <20241128095357.1530-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241126194347.58155-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnke4OW490g157iyf/f7NaXN41h83i
	3pr/rBaHv75hcmDx2LSqk81j06dJ7B4vNs9k9Pi8SS6AJYrLJiU1J7MstUjfLoEro/lQVsEx
	6Yr5k3YxNTDOFO1i5OSQEDCR+P1lLyOMffHdDSYQm01ATeLKy0lgtoiAosS5xxdZuxi5OJgF
	tjBKdC/ZBJYQFgiSOHHjCAuIzSKgKvH96wQ2EJtXwExi6Z1XbBBDNSUeb//JDmJzChhL9E9c
	wAxiCwnwSLzasJ8Rol5Q4uTMJ2BzmAXkJZq3zmYGWSYhMIFN4vj1L1DXSUocXHGDZQIj/ywk
	PbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERiEy2r/RO9g/HQh+BCjAAejEg/vB2P3
	dCHWxLLiytxDjBIczEoivAXcQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNT
	UwtSi2CyTBycUg2M2pOuXT3rOLct4E7dDl2fA0oTQ0wXOV0ym+/hetFzrqeciFznlAS3RNuT
	Dhfkf67U2rj+fPzuVeZbLa9eKn2kVbpqV3XZCsO7gc4WJTUCX320hVZZTlJdcMF4YUXRshVc
	M5r8L62TWXrz3P7qgs5dbcwSAlf8Vvirtv9nOZPJvm/1Vamlv76ZKrEUZyQaajEXFScCAGGf
	3rk+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsXCNUNLT3e7rUe6wfUNuhZP/v9mtfj87DWz
	xeG5J1ktLu+aw2Zxb81/VovDX98wWfzetoLNgd1j06pONo9Nnyaxe7zYPJPR49ttD4/FLz4w
	eXzeJBfAFsVlk5Kak1mWWqRvl8CV0Xwoq+CYdMX8SbuYGhhninYxcnJICJhIXHx3gwnEZhNQ
	k7jychKYLSKgKHHu8UXWLkYuDmaBLYwS3Us2gSWEBYIkTtw4wgJiswioSnz/OoENxOYVMJNY
	eucVG8RQTYnH23+yg9icAsYS/RMXMIPYQgI8Eq827GeEqBeUODnzCdgcZgF5ieats5knMPLM
	QpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmDALav9M3EH45fL7ocYBTgYlXh4
	Pxi7pwuxJpYVV+YeYpTgYFYS4S3gBgrxpiRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8s
	Sc1OTS1ILYLJMnFwSjUwFuT/d/i66K/Eof33Mi/d/3RHvrScdaZa3voNabJ/X8x53PB2ohU3
	70SzkM/NBs33SnS/h1zMUDny76QB12vO7Jmp1Q9nxh21/yzfteJx81SmtXPvnPvpoOuVybt9
	fqaWaWN94d87zeejlPM2NC/f6Oi7xvT6nenqGaGvY85l3T9/RkjG+vf5D0osxRmJhlrMRcWJ
	AMSt+Co0AgAA
X-CFilter-Loop: Reflected

On Tue, 26 Nov 2024 11:43:47 -0800 SeongJae Park <sj@kernel.org> wrote:
> On Tue, 26 Nov 2024 17:24:33 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > Thanks very much for the quick response.
> 
> No problem, all owing to your kind report!
> 
> > I think it looks great but I
> > have some minor comments so please see my inline comments below.
> > 
> > Thanks,
> > Honggyu
> > 
> > On Mon, 25 Nov 2024 16:29:21 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > The kernel-doc comment for 'struct damos_quota' describes how "effective
> > > quota" is calculated, but does not explain what it is.  Actually there
> > > was an input[1] about it.  Add the explanation on the comment.
> > > 
> > > [1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043
> > > 
> > > Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> > > Cc: Honggyu Kim <honggyu.kim@sk.com>
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  include/linux/damon.h | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index a67f2c4940e9..a01bfe2ff616 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > > @@ -193,9 +193,13 @@ struct damos_quota_goal {
> > >   * size quota is set, DAMON tries to apply the action only up to &sz bytes
> > >   * within &reset_interval.
> > >   *
> > > - * Internally, the time quota is transformed to a size quota using estimated
> > > - * throughput of the scheme's action.  DAMON then compares it against &sz and
> > > - * uses smaller one as the effective quota.
> > > + * To convince the different types of quotas and goals, DAMON internally
> > > + * converts those into one single size quota called "effective quota".  DAMON
> > 
> > Could we use "effective size quota" instead of "effective quota"?
> > IMHO, it will better give an idea this is related to "esz" in the code,
> > which means effective size.
> 
> The above sentence is saying it as one single "size" quota, so calling it
> "effective size quota" here feels like unnecessary duplicates of the word
> ("size") to me.  I'd like to keep this sentence as is if you don't really mind.

Since the time or other goals are eventually transformed into a size
quota, I thought the "effective size quota" makes sense but I won't
stick to my term here.

We originally asked this question about the term "effective" itself as
we didn't find an explanation what "effective" means actually in the
doc.  It'd be better to have more explicit explanation as well.

> > 
> > > + * internally uses it as only one real quota.  The convert is made as follows.
> > 
> > (nit) "as only one" can be "as the only one".
> > (another nit) "The convert is made" can be "The conversion is made".
> 
> Nice eyes!  I will fix those.

Thanks, please do!

> > 
> > > + *
> > > + * The time quota is transformed to a size quota using estimated throughput of
> > > + * the scheme's action.  DAMON then compares it against &sz and uses smaller
> > > + * one as the effective quota.
> > >   *
> > >   * If @goals is not empt, DAMON calculates yet another size quota based on the
> > 
> > We better fix "empt" to "empty" together.
> 
> Nice catch!  I will fix so.

Ditto.

Thanks,
Honggyu

> > 
> > >   * goals using its internal feedback loop algorithm, for every @reset_interval.
> > > -- 
> > > 2.39.5
> > >
> 
> 
> Thanks,
> SJ
