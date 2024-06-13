Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C31494D1;
	Thu, 13 Jun 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299433; cv=none; b=Vm47R162DGkKZzt+uikhX9NHP1vurO8cSLvlCINJiNtepn54gLjfm7Pb4msU5kw375sCXgQ4rsWyQ+Bq0GrXpHnYmWiWBEfL1hoGk4vlOCGz4mqSf1/26Ti1urG2Lz8BrHlN8emmJCCGrcTHpTI7rS3SdxYUuvlHd/8qb/iVQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299433; c=relaxed/simple;
	bh=O4ZPjgzbK20CgU+5FqcqMSQLxlhtt5724JpuFdd2XeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhu15MpFaM/Vu8PC3pR6tydw9VbOYY2NKnjyC12d5WWlVhJ+lNf8uaZdNlDW9eapt7OQDcrpk/Xv15/Hw8bqQLYBJYombQrQDuQiN93+Ah21YWj9EAOWXOICL912sFeahTIxiQyqshqruW7KBLpdca6niSqrVFKCEx35QQSDvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1QRJO1G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1QRJO1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760EAC2BBFC;
	Thu, 13 Jun 2024 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299433;
	bh=O4ZPjgzbK20CgU+5FqcqMSQLxlhtt5724JpuFdd2XeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1QRJO1GntK/qeUS7BD0up/CJNZigDlEkid5DUwOa6vhEIgj0pvUfkVub1erNZaYr
	 W9F9aikeaqGd/CpCuX1oiBbHh99snxpBWfUHJF3VphW34mDb/jDsJ/yy2HkPlZ+4nI
	 eJh/Fu1sA8AK1Us06pHQZRK3SVc1Wrsp9ZVdlBdXM9IIkWEcyiBysXgAJbOO8nxU05
	 UYzyF3FW0KiqEcrAlglebMjMzBs9TCAmxdmU0CyTujeXCK4M0GWFUzheoVwwxK0ZPr
	 y417G8akl6lgkZP7p2AJpAT32H7lYip6TwmZqm2SxO9ONVSu6FxjptPiHvscZpmUcw
	 2KG5MCnbL3OuQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
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
Subject: Re: [PATCH v5 8/8] Docs/.../mm/damon: add more damos actions
Date: Thu, 13 Jun 2024 10:23:49 -0700
Message-Id: <20240613172350.63407-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613140729.27177-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 07:07:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Honggyu,
> 
> On Thu, 13 Jun 2024 22:20:55 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > This patch adds damon description for "migrate_hot" and "migrate_cold"
> > actions for both usage and design documents as long as a new
> > "target_nid" knob to set the migration target node.
[...]
> Except the DAMON debugfs interface section, this patch looks good to me.

One more thing.  I'd prefer making the subject more specific.  What about,
"Docs/damon: document damos_migrate_{hot,cold}"?


Thanks,
SJ

[...]
