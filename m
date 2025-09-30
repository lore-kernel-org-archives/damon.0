Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB51531C1;
	Tue, 30 Sep 2025 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193350; cv=none; b=op4rmyRb6DvBNeuCPeyQotMnhlCWqZ7rjAV2ezN5THEW0Hpn+colCF6XFx1WnQxt6lJAqNPvcLQNsW4cULgQn/1o64W9Roo8lznINeyu+uO2E+zW8MUOyihEjGQg78e+gVNgwdPK8RqyA2PvLHDOQT88d9c+ggGK1C9cxcFATWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193350; c=relaxed/simple;
	bh=Dmx25bmLQf6ATWT8g8tetZDOFF0vBbRp6vW8hTDcyvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XN5LGpUaDG9y3SWDd63aGRDenr+/KM7FaeGyiOeo5tsBK7O4q9fLEFLoyuyt99SwzY7LAj6+WgsEMncNMzsf2TmArxO+HcOmnHJ5Gqh6tC6JPEcrQmpKxqoBycqcf/3WpdqvJ+gfq8+/SZ7+RJx5BbZEGFv20+1WiK/zNka76V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhK76q+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhK76q+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6388CC4CEF4;
	Tue, 30 Sep 2025 00:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759193349;
	bh=Dmx25bmLQf6ATWT8g8tetZDOFF0vBbRp6vW8hTDcyvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhK76q+aJngACoGRYQpbuwf9uBLxE7n+FfDFAI6Bz7CRfp9ohr/mdN6MzNy4Y+cbF
	 PJP3xHR20cu+BzyuUy7Gl3Qq82r3fg7EjaQpikJUEUz5+5xCPugK97xs6t9FDM0xyY
	 Hd+vzUifNrzATwg4X9wlRNkTkZm/oMoYzEk7KqYkK9Y6hICU0FW4U7iL6UfuxGRsHK
	 wdZSrpIjBc+gy+9jQDWi0BHwdvjG4pGW4CoT5SkisCEv+htE+KSj5g3N+hDZapdrKc
	 /pSALxpvqkak+zEX88oxB+WXrJ9oaDh9IV3eztg7ZJzgtaHheTeX3az3YS6ksRPxUh
	 ZV/EXsYxjXcrw==
From: SeongJae Park <sj@kernel.org>
To: Xinyu Zheng <zhengxinyu6@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zouyipeng@huawei.com,
	Hugh Dickins <hughd@google.com>
Subject: Re: [BUG REPORT] mm/damon: softlockup when kdamond walk page with cpu hotplug
Date: Mon, 29 Sep 2025 17:49:07 -0700
Message-Id: <20250930004907.55388-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <eaee73bd-21cc-4da2-86a8-fe6a9576ab51@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Sep 2025 19:11:13 +0800 Xinyu Zheng <zhengxinyu6@huawei.com> wrote:

> 
> 
> On 9/20/2025 6:42 PM, SeongJae Park wrote:
> > On Fri, 19 Sep 2025 20:56:56 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > 
> >> On Thu, 18 Sep 2025, SeongJae Park wrote:
> >>
> >>> Hello,
> >>>
> >>> On Thu, 18 Sep 2025 03:00:29 +0000 Xinyu Zheng <zhengxinyu6@huawei.com> wrote:
> >>>
> >>>> A softlockup issue was found with stress test:
[...]
> > Xinyu, could you please test if the below attached patch fixes your issue and
> > let us know the result?
> > 
> > If Xinyu confirms the validity of the fix and no one objects to the above plan,
> > I will post the fix as a formal one with a better commit message.
> > 
> 
> Hi, SJ. The below attached patch is works!
> 
> These days, I reproduced the same softlockup scenario for three times. 
> It can be reproduced around an hour when I increase the memory pressure.
> Then I patched the below fix, and ran the same testcase whole day, 
> softlock didn't trigger again.
> 
> Sorry for the long wait. Thanks again for your solution and explanation!

Sorry for late response, and thank you for confirming that the fix works.  I
just posted it as a formal patch:
https://lore.kernel.org/20250930004410.55228-1-sj@kernel.org


Thanks,
SJ

[...]
