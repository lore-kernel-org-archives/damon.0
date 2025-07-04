Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087B1D7E5C;
	Fri,  4 Jul 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751667253; cv=none; b=RYk4H8tcgY/D/3fdwM+mF0nVVXiGJhAfwqQBSb35c1jlV7/NAvSWd+X/qsyiIg3DAZ+vSeGhsgaKUKlnNyNatldbsaCr6nso/gYhqVXGCXCfwUV0P9c+4i1wosL3FK1KEjB9q4oXVbONi0STw3hhZCjD5lU0OYEUvqydCBd/Z/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751667253; c=relaxed/simple;
	bh=iweyl4UADi/qIPmNnASst+ROilTN90Y7YfVHKjKx0MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q/yJ/vNqEqtC970sG6Q7k9Ff955wzJN7REIK2X6npWa5lTq52w5rbbD0QY24rbo2y08sn9a1NDYC+mg7Q8J3TG+Q2+So71bW1cDU8qtWjocPuwEn7dPuZuSj6FxzqRajtrVZ3n0vgWPtyv+EDp92ork7ILaxcO9ukyw8TJbd5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6EFnAVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6EFnAVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95C4C4CEEE;
	Fri,  4 Jul 2025 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751667253;
	bh=iweyl4UADi/qIPmNnASst+ROilTN90Y7YfVHKjKx0MQ=;
	h=From:To:Cc:Subject:Date:From;
	b=F6EFnAVSOGwjnVn1IFEFhW244EfvLZUgICVSoHKXRDnl6WiyvM0TPPtnUa1KIv0mE
	 44GwDzaryp6XwtD1dk4xLZwYDNf14e7g/1/Mc79Y+inkAG22PCUpGgP4v1TY0xV7/M
	 yH+9QGc1YeeCChJV8mpo14uG76LRl44uMpB9zblZ4F2TsrvNHxOlcluxjMnZ5xoidZ
	 0z6DtfDfDpNn281yqx8m7loEvrANAc/4fbaNOo3848C630fh1k1o9cGI3Musbta1mA
	 1ZD8xg6JgCoC/Dr6Mc8e00edeiOZx1WrUezmIK3/O1EUmX+vS8YWMS8EWvNTGl0J9M
	 mzZ4hYMiuXeAQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon: add trace events for auto-tuned monitoring intervals and DAMOS quota
Date: Fri,  4 Jul 2025 15:14:06 -0700
Message-Id: <20250704221408.38510-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim-oriented auto-tuning features for monitoring intervals and DAMOS
quota are important and recommended.  Add tracepoints for observabilities
of those tuned values and the tuning itself.

SeongJae Park (2):
  mm/damon: add trace event for auto-tuned monitoring intervals
  mm/damon: add trace event for effective size quota

 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              | 21 +++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)


base-commit: 09cf52aa7503a7126edc3af797e116a7ec49e572
-- 
2.39.5
