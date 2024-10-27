Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511A17E8E2;
	Sun, 27 Oct 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062153; cv=none; b=NMhZ7cou21iIBMzkE4LfefBmKcWGakmZ0FRv/LwVC2R7irDhFooTD4qIQfy7o47lg6z5vDnmeGZ1xoeL/4x4Fn7bgH1Na8DbWTh0jyZBzfRGTs3DP4LjkNeg1cWUiAsEy+3ysFiKLLN8Th7yEGgur4/c/c2Mq0zelRzyZ8N3DFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062153; c=relaxed/simple;
	bh=4N2IXPd0awSUXc0msCMuY8ABxxknYk5+HRsYIZWs06E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVl/YY5kmH/Q3AQI4nJxEOrJuWF8bcOhcoVPJqx498MTmkQPmv+f4BB9zd+iQtH3DQYb6CKXw8sJ4eC8jQ8XamMj1q7EvVojX8x4XS89x3DytBuxWBrhnOhXxx7qXIGx3InYsI0bQfAazUTCw78qWrfww9YIFlBM02hAf2lop40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYcDLOlk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYcDLOlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA693C4CEC3;
	Sun, 27 Oct 2024 20:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062153;
	bh=4N2IXPd0awSUXc0msCMuY8ABxxknYk5+HRsYIZWs06E=;
	h=From:To:Cc:Subject:Date:From;
	b=DYcDLOlknuhLoF8/ob1wzrJGL6pq4r8WcONkTREQ0gDiMWsg2Klsx3I6SK6k0qA2p
	 4f9ayVqpEwYdf6LBOtDJwOoDRjFTC2Da5nzWwF3Uogr9XaK8T6LK7oUEjFc9y+jT9d
	 EhXlVbg94ty1yz4FRBNfzGZ81K1MOy7YJEJxbzn0EnNCe66jdjouPdHZyxagxD06WI
	 bWWDvAw9tu4q4o3+NoByjOT7ZiF4yiksBS3By6mAG0zvVhdCRYIX3vemM6RAYJRHQp
	 pwga4s04gf9G3WSazUJ1XMRuwJ1R32Rbtj3+3K8Io/JtYsyXN9ouljRjrXD1LDZMG8
	 LLvac85nUiPng==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Fwd: Two simple ideas for DAMON accuracy improvement
Date: Sun, 27 Oct 2024 13:49:10 -0700
Message-Id: <20241027204910.155254-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forgot Cc-ing linux-mm@ and linux-kernel@.  Forwarding.  Sorry for noise.


Thanks,
SJ

=== >8 ===
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
CC: SeongJae Park <sj@kernel.org>, kernel-team@meta.com
Subject: Two simple ideas for DAMON accuracy improvement
Message-Id: <20241026215311.148363-1-sj@kernel.org>
Date: Sat, 26 Oct 2024 14:53:11 -0700
Local-Date: 2024-10-26 14:53:11-07:00

Hello DAMON community,


There were a number of grateful questions, concerns, and improvement ideas
around monitoring output accuracy of DAMON.  I always admitted the fact that
DAMON has many rooms for improvement, but was bit awary at changes for some
reasons.  Now I think it caused some unnecessarily long delay.  Sorry about
that.  Now I want to invest some time on the topic.  So starting by sharing
below two simple ideas first.

User-defined Regions Split Factor
---------------------------------

DAMON's "Adasptive Regions Adjustment (ARA)" mechanism splits each region into
randomly sized sub regions, show their access temperature, and merge back
adjacent regions having similar temperature.  The split factor is hard-coded as
two.  Increasing the number make DAMON regions more quickly converges in right
shape.  However, it makes number of DAMON regions in usual situation higher,
and therefore induce more overhead.  It will still keep the user-defined upper
limit (max_nr_regions), though.

The optimum value of the split factor would depend on the use case.  We will
therefore add another knob to let users set the factor on runtime.  The default
value will be two, so this will not introduce any regression or behavioral
change to existing users.

Periodic Fine-grain Split of Aged Regions
-----------------------------------------

If a region is continuously changing its boundary and access temperature, it
means it is converging, or the access pattern of the workload is not
stabilized.  Either case, this is a healthy signal.

If a region is consistently showing same access pattern for long time, it may
because the access pattern is stabilized, and the region is correctly
converged.  However, it might be because the access pattern is changed, but the
converging is slow.

To avoid the too slow converging of aged regions, we will let users
periodically increase the split factor for regions that kept current access
pattern for long time (high 'age').  Users will be able to set the 'age'
offset, the split factor for the aged regions, and time interval between the
periodic fine-grain split of the regions.  For example, users can ask DAMON to
"split regions keeping current access pattern for ten minutes or higher to five
sub-regions every minute".

The feature will be ignored unless users explicitly set those, so that it does
not introduce any regression of behavioral change to existing users.

Discussions
-----------

Someone might worry if these are adding too much knobs.  As I shared the long
term plan on last LPC[1], we will keep supporting those new knobs in long term,
and may introduce auto-tuning feature in future.  By letting these user-tunable
first, we can collect experiment results and use those for the future
improvements.  Anyway, these changes will not introduce any regresion or
behavioral change to existing users based on the idea, so I believe these are
safe to be added.

One of the factors that made my work on this topic was absence of a formal
DAMON accuracy evaluation method.  Using damon-tests, we were able to do the
evaluation by drawing heatmaps of test workloads and comparing those from
different versions of DAMON.  Comparing several DAMOS schemes results on test
workloads were also one way for that.  But, those are not formal.  We still
don't have a formal way for accuracy evaluation.  However, the two features
will introduce no regression to existing users, so I believe this is the path
forward for now.

I believe implementing the features would be not difficult.  So unless someone
voluntarily steps up, I will start implementation of the features, targeting
v6.14 merge window.

I'm looking forward to any comments.

[1] https://lpc.events/event/18/contributions/1768/


Thanks,
SJ
