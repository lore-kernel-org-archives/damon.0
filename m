Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8E47F3CB;
	Mon, 14 Sep 2026 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397438; cv=none; b=KLbdPw7KLbnfJBfk70Uc+3EPSA5mhz5FJLiUYhASLppWc2BdHCdjnPbY2GsLgqHJW029bXpRkuXgb/29RzB5DTjYhmHan7J5snTPBqw5PWpLPzYyEAF7KR3fs02lwgld0x0yZx8d2VGVY6V+1nDi4KDkcxh+SxQN/EKJ+wFRRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397438; c=relaxed/simple;
	bh=uAX6tpMiWWWOWbLHaGqSlvPsehR39N8Jg0uZlK/KESw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFupByrku1l2SuKppxqGajnl0mOQokH3vQGD2jhHZ47BkaKUcM+ASCEt4Gd+va9Fqife0I7wSz/tK/EeXHqI4m2BFUD0pDPtiAwQHLpV4CNX56L9pJ0qKP51iPBgmFS+hg1dZloSFlgDHUCSmxr9hF8BPtHbx5G8tpJCwjAOFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrh5nycr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrh5nycr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1861F00893;
	Mon, 14 Sep 2026 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397436;
	bh=DdSX/wEBxUG3+6tT6fIjeyRChWGrmi9MuX4lYifuSLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xrh5nycrsmxLdc0/rrB872qvYgTBBsiopVxuoL0Eg76RwQd4wfl7SIELOttWi7vbf
	 67u945e7BRvfzE1fM69NYRvHQ6om7BFeIp5Axac812YZKEsAioBldiq8FFK6VeO0jr
	 BWNIimoefN9o7bUuSaYhqlAbZc3jaMMFWlVDrsuBXMOp7bKpdducaLnmKclQ3Ap35H
	 lPDa3GSujp4JT3vIIiFJ9yuMBzF/cu2rObi4GDzzbloWSDcJk0W4KOLExovapM+7+I
	 p3NMtyfiLm2goxQuOR042ubCTl0Nn1hsBA/gB4QoXl1xeNoPG2O3jst4eO/QO20/Qy
	 DBt6n7R3GJiNA==
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
	Randy Dunlap <rdunlap@infradead.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
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
Subject: Re: [PATCH 0/6] mm/damon: misc improvements in tests and documents
Date: Mon, 14 Sep 2026 07:50:27 -0700
Message-ID: <20260914145028.94705-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 07:19:45 -0700 SJ Park <sj@kernel.org> wrote:

> Add various improvements to DAMON tests and documents.

Sashiko found no blocker for this series.  Sashiko send its findings to damon@
mailing list [1], and I reply those if anything needs to be clarified.  Please
refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
