Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDC357D0A;
	Fri, 22 May 2026 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481323; cv=none; b=Xk20dHoMq8WN3YKEOPnD8NEHRNAMo+Vy9lyj6JAFyTddqU/BJZ+7xAPxCGZFe/VnAWBLTFbEmci5/dAoUIEVE+kGXBDWNfjO34eR3rRG2pbFrY2kbf5FFg3LJKKXaW5QWB/yRItsy18RNGGIn8msdfnyhdbiLBkJZcgscXVMl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481323; c=relaxed/simple;
	bh=fSbMVu3ah0nsu97Gb3B7/Vg6J5D8u9sXdHLN5YFOtB4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wo05SYYw1k517BKuwEXo4PXGzvhvZ0M85IQsxYMcCrrvZQ4O/Xhg/OTlH2Z+fz3IilkPGh4vxQVIJ5D6HJlTWEmGVVdDYhWscMBL7GsXVEQKB/yxbmWJPUsua4a0NZzS8XChz54yAQ2ukDL5H2UNcRDCG3yjLr11ohZHOaSw7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eNkr+pGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eNkr+pGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B7D1F000E9;
	Fri, 22 May 2026 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779481321;
	bh=sVT0GsCmp0z+OWsAjvQLKMuJ3m5x5E4LmFka9n4wvlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eNkr+pGCvFyU+hJOQ5+sjI7sgFViRAD56CGaDdboAN3PmGKsdx85UXM90IJZ5ZidT
	 zRSh0h+8vwXq7tT3cVfcZ8DFHzZN9Wtg/Tkn4Msz+BFBHUq6hdcfiIYxYbhugZjU6y
	 IXHbeUPXpUxA32IapFjcdhdJ+8kr3HXVb9sGNPig=
Date: Fri, 22 May 2026 13:22:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@davidgow.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 00/14] mm/damon: minor improvements for code readability
 and tests
Message-Id: <20260522132200.fc3505a9b9af4243b960547a@linux-foundation.org>
In-Reply-To: <20260522201352.3459-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
	<20260522201352.3459-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 13:13:52 -0700 SeongJae Park <sj@kernel.org> wrote:

> Dropped individual recipients except Andrew.

Re-added them ;)

> On Fri, 22 May 2026 08:40:11 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Implement minor improvements on code readability and tests for DAMON.
> 
> Sashiko failed reviewing this completely, but found no blockers.  Also it
> didn't find a blocker from the previous version of this series, which is same
> to this version except the baseline commit.
> 
> [1] https://sashiko.dev/#/patchset/20260522154026.80546-1-sj%40kernel.org

OK, thanks for checking - I'll add this series to mm.git's mm-new
branch.
