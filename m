Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7A1A254B;
	Fri, 14 Jun 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382985; cv=none; b=VIYzkfVIgGy+LOnNjOcX65lVMVfEc8axF8+4L58QR91FMk3Y03HVzGdQKTfPhM5FLfDgmCUbvPBPGBDvLdj32WNPPYrAcS2kCDxJbOjYaYwj8zkfx/d9u0n6GvbsiIAzkMBOWrz1IPZy761IcD1FGbJYL7R0T+icbkfej5UUa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382985; c=relaxed/simple;
	bh=md8eyVeN/KeS+yB2AYtWSArhSrCHpdtliBmbVjPIafk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+lpbzhhQwsmuR9WhCaR1m/3gTcskccC9DiX6gfguyssLw/QrEFa8rvF3gRlt4G/CcbuvWLdfGf09guymkqT1IgRAaiD3ASdjsFdB3JyO39tBm2Pyxd/0XGuna8YlkhctQx5HIkahDJYbUP30nFPqoW3JJtflYny+kvv9azKVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7ob45kq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7ob45kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992FFC32786;
	Fri, 14 Jun 2024 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718382984;
	bh=md8eyVeN/KeS+yB2AYtWSArhSrCHpdtliBmbVjPIafk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7ob45kqeeWGvRCM3kMMe/VTaZpmmsubIqeULeyP9ie1dSneZmLK5Zm1f+uKl8pfD
	 +Yn2DsZEHeFS40mcvkPYrGsf0mQTBDFpk7ljRGF7DtGmc0d37TQTQHsLR034RpJ4I9
	 zPIUscU/6ZAez8vg9vyNeIFsO1W5u1J+YygSmf7ZSJDsfe/iOc/9jUXseRRvOhG/mb
	 qBkYdTpH+9/5aLbWHJZLLEEqf1pTPzOLT1m++dfzBPTJ7e8tSKsS9Hc1zW3ZZP8iOA
	 Wozevlq/ECDtemaq4wLNLhcgbf6oam6gUvVH867wnIXqX6ob8vNizk+xjsioobzBXQ
	 tStFvfoR2MhiA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com
Subject: Re: [PATCH v6 7/7] Docs/damon: document damos_migrate_{hot,cold}
Date: Fri, 14 Jun 2024 09:36:20 -0700
Message-Id: <20240614163620.85451-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614030010.751-8-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 12:00:09 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This patch adds damon description for "migrate_hot" and "migrate_cold"
> actions for both usage and design documents as long as a new
> "target_nid" knob to set the migration target node.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
