Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9D35962;
	Sun, 23 Nov 2025 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763927713; cv=none; b=R8JQgEc0YbhcCVaE99QelMBMQu6Ub5wK0NVzAGFb9Yjrm3HXrdGI9LOHJLufXhKHaQ+DPMzXdG3WnIiluj3YH3XRc4dFks2VTSKCvFTZcj+MZYQ9pYQOE33P0p4uaiOTfVN/2RyW0JBhqLr4KJ8SKLRrM6VbqVHvAhdVpgs02ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763927713; c=relaxed/simple;
	bh=ONzvLa3ZaViSZ5gG52gKU5AhTjht5Jg3NT5f81KKlSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFAAqiDCZEJJCnFUfK6MFB6y1uHmV3lpoFATNlRMZVaceNRvJXxqgqdoaFihAlMAUXaXZ/g4hOpvGU1zH6TsbXYsLgIRKkA2gZYtdCl3qC1Fg12YGg4N591EjeGYCtJupNT71uCeblHdhMscTVBHJ87SUUEC7z0a6MW2xpwN9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skTlV8tc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skTlV8tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75FCC113D0;
	Sun, 23 Nov 2025 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763927712;
	bh=ONzvLa3ZaViSZ5gG52gKU5AhTjht5Jg3NT5f81KKlSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skTlV8tcUzDnx2NS3oZTafwFn37YIjjnSUVdOBv824NMHQ+dj9G0HAp8SEFSOrXTa
	 Vm6RwVSDxdU5umROdYBSsirLxayteUVafAXZo3AbG60PFDpUDeajJitU5UVbG+3IfZ
	 g8WG5HQIiQbHNZMhqCBJcFzTEHG0oL1zdIloVCRxiKWjWLZW0yTUrbXFRsbqmYv37M
	 WTD7XlpSEIi5yc+d/whvBmMDK6vGXzlC0vRmzxl96b8QjYTOjfl+ZhGT7Hx2zdklFM
	 izzBK/4PQb53PSkWoUsuMoOAcfpOPln+yrqaS8MfKbN8s0TcIQE403itH1Sw6ViSWq
	 Nm1xpdMvXtnRg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] mm/damos/stat: introduce nr_snapshots, max_nr_snapshots and tracepoint
Date: Sun, 23 Nov 2025 11:54:55 -0800
Message-ID: <20251123195456.24755-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 23 Nov 2025 10:43:14 -0800 SeongJae Park <sj@kernel.org> wrote:

> Introduce three changes for improving DAMOS stat's provided information,
> deterministic control, and reading usability.

FYI, I'm not aiming to make this be merged in 6.19-rc1.


Thanks,
SJ

[...]
