Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D12609FD;
	Tue, 30 Jun 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831453; cv=none; b=sGSvzPQeAQyT+qvZVs8zU+mQkCZKKXpoIpymnobhE6setlfhxbL6kA+wxDDkffGqh0t4TFimgpxjkcuCoE0WpO5xDRtQd4K7JcLU53m7rQfL8DzLJcDU59ZDh9ZUQAnnWAicrXhRZZf4ATyzg7mbb/3krURnr+++jpY1ZG8OHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831453; c=relaxed/simple;
	bh=wCS3CGlTAPFqjpzIeJR1CFEGc4FBDpqHNkDW/1nY3eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESt4s5RW05eZoBj/9cjnXc0nU888CPwh+HNakVPf+HVlfN354DKN2vjjrK1DJQOH64FMIhgqXaEkqE24dj6X5ddRizaVEINyavHJFgdITxv8dgTbYbt+I3Pw5SfXEaugJqd6P6cLP3vwj73KoL3xIqsS1wymsQkrEfunAKUGUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKqN86No; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKqN86No"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35631F000E9;
	Tue, 30 Jun 2026 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831452;
	bh=Rt/iGbOFCZMV9bCDf5rxqRe3XsLLEE61YR1XtIhNQok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKqN86NodSgPmPa0daU/LTKKagv0DcFCeGMhS6MgVwObdnzmatyb5UisR30Aa67Xk
	 UF8Yikd4V0jvra1ltipSVud//K1T/IbdgT0XbO+HgUp9mX4tyeXS3/nNd0FXWYurSb
	 GeFtNYI1dABj6rRvj/tn6uBv7VbcA+YNI+vCD04myI1Sg6Svkd0+P2ENuvY//ghV1i
	 0uW5zDuVnefztjVi8KSuS5DqaDXi1RgNx+np4UHs+Lcj4U/Rl1ywlHHxoKE+EnF5/d
	 HyQ1jyi3BzKD6JnuwYd9olgGQdLoHVj/hjNNwDE1tSYfGEocOE4Vgnc4fNc/dJMZAB
	 LHuQYbCiN4W6A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/11] mm/damon: update, optimize, and clean up doc, tests, and code
Date: Tue, 30 Jun 2026 07:57:24 -0700
Message-ID: <20260630145724.93141-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 07:17:14 -0700 SJ Park <sj@kernel.org> wrote:

> Patches 1 and 2 update the design and ABI documents for recently added
> DAMON features.  Patches 3-7 add or update more unit and self tests for
> DAMON to cover recently changed or added functions and sysfs files.
> Patch 8 optimizes damon_commit_target_regions() to skip unnecessary
> adjacent ranges setup.  Patches 9-11 clean and fix up recently added
> DAMON sysfs interface code for readability.

Sashiko found a few things that could be good future works, but none of those
is a blocker of this series, in my opinion.  Please read the full thread [1] in
lore.kernel.org if you want more details of Sashiko findings and my replies.

[1] https://lore.kernel.org/20260630141726.92246-1-sj@kernel.org


THanks,
SJ

[...]
