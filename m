Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D215217F2C
	for <damon@lists.linux.dev>; Sat, 26 Oct 2024 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729979600; cv=none; b=bUxBy/bsPU+yNsEkBvAAjewIRRGNwvMcFSYrF96GNTbw/Kx6EQ1KpL5ZuLUXVAEVGWOBzmZcO+h6vKaRdWwf2zfsVtTms6ofgPCla+35BJK7aDsY/v2ldJ94PapYHr8uHq3H6cOKhvh8WsJ41wf0qBLWtmcui4IzXStV2ZbUIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729979600; c=relaxed/simple;
	bh=JbGyPx6YfcrM/u7KW9v0IoAVDUIDwOzYrsqXQfQ+Cao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L4IbzW8HQN4+VBIhjQlIIXNmzFQN4wBlp6ZelAqWOOINMsxONRKGcZtXLdyZIPAbI8iyb7elhmnJcIi4YwwZ5R5AIQk4Cu6uzHJA8NyZRfJh+Gff34TKNSczCSjDKLVJTzEp4nVq7Rznp1MGyw03uxVbNaO/hslJQk5Kj784rQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/xdfS/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/xdfS/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DD6C4CEC6;
	Sat, 26 Oct 2024 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729979600;
	bh=JbGyPx6YfcrM/u7KW9v0IoAVDUIDwOzYrsqXQfQ+Cao=;
	h=From:To:Cc:Subject:Date:From;
	b=E/xdfS/8/+GaMF3psLjV2/p4bVUjHe4sVtwqZYxkYemt2wc4h2XBFTO/9IwKnhP/D
	 UliUAUyEpwSd3I2Hfj8uwRNmKtALakcYsEaEUngPy4LWspGHs84MflVqnAeF0HScZI
	 6A3mS0qDiVsoQEDZEjDjhjJlJPiwivAVvbnY35dY3XLMLArcuOMJGvf3tAdZiowsvE
	 VXz8aWdT/LP2bdGdjDRU3QbNr57qMkUAKJTQ5hydjOyiEH9033fLGVaZ+MxUG0wndH
	 JSdpAotzfapJ+0h/hCWcOalOqJ13SYkt2rKk1pDUVwmswurQHlru+9OdOlg61BLfLR
	 OQJMvXgJy184w==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Two simple ideas for DAMON accuracy improvement
Date: Sat, 26 Oct 2024 14:53:11 -0700
Message-Id: <20241026215311.148363-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
