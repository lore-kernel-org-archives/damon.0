Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5832D780E;
	Fri, 15 May 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805703; cv=none; b=A+ZxsdBCNkr2rrw4xhjkZhaSuouQOBL4TRmgu+DER8YjAsN00DxbXxpYu9yKCiB4eCc/+v3sgxW/huGTEN7izleeZcFbn33RZFfiyKEQL5d1dkw8BjrKE5zoXWF8MZ+W/WDet2mLy8C2HDIqnX6TSUJS/3RgdICySInv+Fku0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805703; c=relaxed/simple;
	bh=bJO/kE6QL8D7YE9Smgjkz8t6WHx6lrXs3dUs2I0Uj4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvRN0ubZqxQOZMMnW31U6iJy++0Ucwek+bXhE+mTm4NmkYchdm2wJ7z0fQVJaMVwtJ0txkYScOXgsNpJpkTkE+Ea5Bal5ADM0yMbGoRUIolHvFaIWmOsY2sUKHiVUymTL7zTI28jcsYd+k5psauh/SIKor8DZL3BT3E/lLADrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuT4r9ID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuT4r9ID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C266CC2BCB3;
	Fri, 15 May 2026 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805701;
	bh=bJO/kE6QL8D7YE9Smgjkz8t6WHx6lrXs3dUs2I0Uj4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuT4r9IDxhWGJMY8i0Orgn14YjsiKpbutBYqr8dGd1vTCRBcCuUCOpewlaakfONzp
	 QsxEHIe9sDc85rA5RZcp8xojiuICNxgnTmNAHKaFbSqh4/ZzO9uvueP3i/hdhp81YG
	 jYiyZrgCfo8Qy2QtsNB8v3ogmc1aTR4A1K09bYtQm9Z2Ikz7l14XkOsJXtojO1qcRh
	 kLFrsPZLLMPp9TVihzV7qtthA/ALQQxy9k8u97Mk8qyfT25CgGPep+biWvpjLHeCzJ
	 JfkfUlUnrLK5+NWtxyZhavCQcKPmj9hL5Zig4+XRMQB0uhDBDOxozoYvru2IMCNlId
	 BV4SEzx1hK0jg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2.1 00/28] mm/damon: introduce data attributes monitoring
Date: Thu, 14 May 2026 17:41:19 -0700
Message-ID: <20260515004120.128430-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 07:08:33 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR
> ======
> 
> Extend DAMON for monitoring general data attributes other than accesses.
> The short term motivation is lightweight page type (e.g., belonging
> cgroup) aware monitoring.  In long term, this will help extending DAMON
> for multiple access events capture primitives (e.g., page faults and
> PMU) and eventually pivotting DAMON to a "Data Attributes Monitoring and
> Operations eNgine" in long term.

Sashiko failed [1] reviewing this due to a problem at finding a fresh baseline
commit.  I will shortly post the next version (RFC v2.2) after rebasing to
mm-stable (7.1-rc3) for avoiding the issue.

[1] https://lore.kernel.org/20260514205555.51653-1-sj@kernel.org


Thanks,
SJ

[...]
