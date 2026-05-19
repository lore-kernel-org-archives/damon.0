Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CB2580D7;
	Tue, 19 May 2026 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152096; cv=none; b=Ljn1SBc198HabTnJc90eU7BDJFwEdO3HfUWxJTFEnzTiHjVP3CN9VCDyrAnMvhbQMs3kRSQP0nfvXW4YjaAujHgjb4W21rPPOsMLl/O+pzx6C7xkgYgOqikNKXWAZ7iN/NAYVzUHgrWYnCVKDhF8oQHEt2Spakf+j/ZtCEOixiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152096; c=relaxed/simple;
	bh=rjK+kkOfq8osA8oY6NXr+4d4KyeVsosRN8eq39UvKYg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V8f6DBj6woCgfyziQVqlAUJoTczKRVNGXlfJv8TEJxhR57cTgk0HuRRTEHwBBOpcJdgVv57b2rmTDPTUWrw7ym8bQELZ7juuXQAL/HlN7Y8JcDCBQA8mB+7OUIgv2RrbcmaAVsRzFSiNOJb5K5pGuLdNsyAssscpipI7qioZ0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vK5R7wNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vK5R7wNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70072C2BCB7;
	Tue, 19 May 2026 00:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1779152096;
	bh=rjK+kkOfq8osA8oY6NXr+4d4KyeVsosRN8eq39UvKYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vK5R7wNWdyEsDjzjeRvL9vOaPwLXy7ax6Zxw3caXnzB5E8TsIepJzz/Il/kSIGVUC
	 sfszVBboFtw7yIBMCrWn3ezkcoqZGFJFh2OFlcHNuPGyX/vmKwFntLlLQh6/S+eRvq
	 b7qAcfAcU/jRgIdb9kPwUMSoFBtmUmUHoJSrsDkA=
Date: Mon, 18 May 2026 17:54:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes
 <ljs@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Michal Hocko <mhocko@suse.com>, Mike
 Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/28] mm/damon: introduce data attributes monitoring
Message-Id: <20260518175454.d968f11139f64c3b8d93a5c3@linux-foundation.org>
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 16:40:48 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR
> ======
> 
> Extend DAMON for monitoring general data attributes other than accesses.
> The short term motivation is lightweight page type (e.g., belonging
> cgroup) aware monitoring.  In long term, this will help extending DAMON
> for multiple access events capture primitives (e.g., page faults and
> PMU) and eventually pivotting DAMON to a "Data Attributes Monitoring and
> Operations eNgine" in long term.

Added, thanks.

> Plan for Dropping RFC tag
> =========================
> 
> Making changes for feedback from myself, humans and Sashiko should be
> the major remaining work.
> 
> I'm currently hoping to drop the RFC tag by 7.2-rc1.
> 

I removed this section.


