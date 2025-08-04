Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E928852C;
	Mon,  4 Aug 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326624; cv=none; b=iiJMOZZN07qFFoNttzTkq+CZNet8GRjowecmKHiwFrDgrNAmvbkX2gVIANd7J5EcyeMZBqcE7hTR2tvhNII9KKNDV5xKbcIIYD5Psr1bvgln0AGXamDoRrslTUCZyHKqfRx2PEs64aO2ZCFps8S1Ifcpz1/RlHWr+BDVWdBWnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326624; c=relaxed/simple;
	bh=KgrilMzrEhJRh14HSH0aWw+CjVXehntvFtCz3/m8aWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Frq8aoUDl5uIFCD16mQauyA6xkE7/GRbjyXatUfKBzV6McJPREm5Vn1zvTmGSFMD4MroT7XsnNulZvmvRLbSqMsBEYz/nd0+5rvou01ujFflGSczkHpQA5cMD27/PZ9ioN9nbQJ1xNX3uzgW416D81hM+RYOP4h98wnrS7MFS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIkqJcqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIkqJcqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D6DC4CEE7;
	Mon,  4 Aug 2025 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754326624;
	bh=KgrilMzrEhJRh14HSH0aWw+CjVXehntvFtCz3/m8aWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIkqJcqCoAt2/gW+CTzEp3bXhnHd7afe0dwZSB26D476vDZiWuRK7m5g2/ucoggUH
	 G31C9l9D63v+UAge+qfOZzllcrneFutLtwI/NVCqvdklXLZfw61dBryhna9eWzJohz
	 hQGsbVWKk98Mu4xgBg67zrKr9KZ+yV+wPv+e9IgyI4TN/jbnty0Gx/1vOuTbepQmzG
	 ZeiSciyGBQUnI1WcZq6tMBWFGCelGiTBWSusCeVaWfrlkjjjmr9olYOqAorTDo7pv5
	 DqK3zU5gVX2Zd1mgKdL25QWfnPImSx+XYi2398jYkS61PHfhXep4a6gAZJMMP5rgGN
	 qu0vUCNNB1c7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Paniakin <apanyaki@amazon.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Michal Hocko" <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	amazon-linux-kernel@amazon.com
Subject: Re: [RFC v2 0/7] mm/damon: extend for page faults reporting based access monitoring
Date: Mon,  4 Aug 2025 09:57:01 -0700
Message-Id: <20250804165701.55642-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aJAfTUh-49pYuhbg@3c06303d853a>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 3 Aug 2025 19:47:41 -0700 Andrew Paniakin <apanyaki@amazon.com> wrote:

> On 27/07/2025, SeongJae Park wrote:
> > TL; DR: Extend DAMON interface between core and operation sets for
> > operation set driven report-based monitoring such as per-CPU and
> > write-only access monitoring.  Further introduce an example physical
> > address space monitoring operation set that uses page faults as the
> > source of the information.
> 
> Thank you very much for starting this update. RFC mentions write-only
> monitoring, this feature particularly would be really helpful in some of
> our use cases such as lightweight live migration target selection, so we
> are looking forward to collaborate in development and testing activity!

Thank you for letting us know your interest, Andrew.  This should be helpful at
better prioritizations.

Now development trees of DAMON and DAMON user-space tool support[1] write-only
monitoring.  The implementation is dirty and not upstreamable for now, but
please feel free to test and let me know what you see if you don't mind.

I will continue working on more testing and making it upstreamable.

[1] https://damonitor.github.io/posts/write_only_cpus_only_monitoring/


Thanks,
SJ
