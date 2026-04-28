Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6E175A72;
	Tue, 28 Apr 2026 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336401; cv=none; b=Et8tvOnyK40fYz4pWqqYUffZAQF3TIxb2Xaq7re+hUDRHpDeWiwy6VScFtxVu/9z6xpYt5L2gKCQJmQ5A1u+FuVqelFVgKnwndgiTVDyOlOCpQDlR1eY26rYo9Flfr5uLQREHskgsyqcRkbRbUj9uTZB7xezhX3Er06kiQNf5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336401; c=relaxed/simple;
	bh=ZcdrUd8JxPkWJLg3gCpjoRkvfIkDc4Y0TOh/l4kL4Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1NtvtDd3AVHr/QVBrRGZlPFGrAlR0lvae/7pbVbIK6qcEKrfN1aPIh4ZmjFJuC/JlUOnRjEQodE9P/RDpznFOCj4z5znJn2m9gqmt8/gnERi1HcDtRWN/zFUi1rYaMB7zANB5osRY/72NmQNjMNBPk3Eb4DRqgmG67sgZOlgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3jmgxmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3jmgxmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5E4C19425;
	Tue, 28 Apr 2026 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336401;
	bh=ZcdrUd8JxPkWJLg3gCpjoRkvfIkDc4Y0TOh/l4kL4Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3jmgxmjb5NsMB8nfzuMsp69890MkKukIXm/8fmi/oAu9/3CXkSuiXwt6PDYr0gZf
	 7fZ75Myat0x/3+Qgzk5m718sTFdDuSv+vQKMSlrXX5rtosbKcHZ6p66XoWH0KBNQz4
	 Mx39vjSDGQkzTkbLelRE2IvPFwZDZWQJIeJFo5tGEF0DcqEXfNVppjoXLU8wUk41Qj
	 IN1Hynk2iSKbZyrz7+rbQsGOv960XvAHG1pEJ5lXeNUa2ObV+UdIF0g6P1mzkSBRqa
	 2a0VvJrHZenwNu8kYf5JBAb+BaCTYppN0dzLpVPwU8MXCysmCUsbsFdTIdwW4YtxWf
	 YgwsXKhj6cm4A==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: Re: [RFC PATCH 00/19] mm/damon: introduce data attributes monitoring
Date: Mon, 27 Apr 2026 17:33:11 -0700
Message-ID: <20260428003312.113061-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <14036b07-413e-4dcd-a363-e7f834d85da3@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 16:16:07 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SeonJae,
> 
> On 4/26/2026 11:52 PM, SeongJae Park wrote:
> > TL; DR
> > ======
> > 
> > Extend DAMON for monitoring general data attributes other than accesses.
> > This is for enabling light-weight page type (e.g., belonging cgroup)
> > aware monitoring in short term.  In long term, this will help extending
> > DAMON for multiple access events capture primitives (e.g., page faults
> > and PMU) and eventually pivotting DAMON to a "Data Attributes Monitoring
> > and Operations eNgine" in long term.
> 
> Very interesting. Looking forward to seeing this in upstream.

Thank you!

[...]
> My main concern is about potential pollution of sysfs. DAMON is already
> complex to set up, with a lot of knobs. Adding more configuration options
> may make admin's job more complex.

You are right, ther are a lot of knobs for DAMON.  Nevertheless, each knob is
simple and independent, so easy to scale.  We also provide user-space tool for
users who still want to use DAMON in highly customized way, and DAMON modules
for users who want common purpose usage of DAMON with minimum tunable knobs.

I believe the beginning part of DAMON usage document [2] is explaining this
point.

FWIW, I'm also working on DAMON-X [1] for making the modules based appraoch
just works for more use cases.

> 
> Do you plan to support this extension in damo user space?

Yes, I will!

[1] https://lore.kernel.org/linux-mm/20260307210250.204245-1-sj@kernel.org/
[2] Documentation/admin-guide/mm/damon/usage.rst


Thanks,
SJ

[...]
