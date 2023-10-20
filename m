Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845920318
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XIbOXKyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D8BC433C7;
	Fri, 20 Oct 2023 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1697823037;
	bh=cJeCmKC38qm90zyfdcG4SUKfILLYa+5rU2Q+LCqJ8lM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIbOXKykVs348OUb2DLZnFwaZAO6yQOODMlyMioGr7OgM6CvBy+LNZcvXM0I9N1U1
	 9N94CneC/tHv2yls/XwFziprrJXA1NQGwu7D3VG75vhzQMvmrGovs7eabtAjPKjT/x
	 ncOf/qPcc1NjxqBFZynMjaCLtE3pn3839yr3DUfw=
Date: Fri, 20 Oct 2023 10:30:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 acsjakub@amazon.de
Subject: Re: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses
 overflow
Message-Id: <20231020103036.027282d16aaf56498230cc12@linux-foundation.org>
In-Reply-To: <20231020171901.63994-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
	<20231020171901.63994-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 17:19:01 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 19 Oct 2023 19:49:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > The maximum nr_accesses of given DAMON context can be calculated by
> > dividing the aggregation interval by the sampling interval.  Some logics
> > in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
> > shouldn't be zero.  Such case is avoided since DAMON avoids setting the
> > agregation interval as samller than the sampling interval.  However,
> > since nr_accesses is unsigned int while the intervals are unsigned long,
> > the maximum nr_accesses could be zero while casting.
> 
> Actually, the issue was reported by Jakub, and I didn't add 'Reported-by:' tags
> for him.  I sure Andrew could add that on his own, but I want to minimize
> Andrew's load, so will send v2 of this patchset.  Andrew, please let me know if
> that doesn't help but only increasing your load.

Editing the changelogs is far quicker than updating a patch series ;)

btw, it's now conventional to add a link to the reporter's report.  The
new "Closes:" tag, immediately after the Reported-by:.  But it's not a
big deal.
