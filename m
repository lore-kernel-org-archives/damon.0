Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F14611CE;
	Tue, 21 Jul 2026 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677923; cv=none; b=K85hhw07/mhVhyFLuYlWg5ZnKDthNcTbr2M9RnScG9nJzAaLog/XTC15BYcJ0ZqQucFSgjQX7MiunMQVLmjY7eEwpw8X62lSsi4zjJ0Qn1+aJH9vXiWQtydYsiS6Q5ryxY49saSWZuq8j63wKOjDnMUHP0i++DhyZTVjUgD3YsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677923; c=relaxed/simple;
	bh=jfAy3NbOLR8I/v6Q+8e2giTnR875dr+/1aQpzC1FcqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKME/vNZVnqSSXdCvXunsOidKGWsRmP9/FsKz/0FuKGSArL/VS5gTWC3gSwK9M+4gWvv+Jnj9BbOdSbsdL9DUO0gp/5elEiabLDwabeAJAqWZmP8pP8Cf64K2wtvJRNeJY+VzGAshhSOE7VLzJAR59G0qs5RZ9XlfM6OEZFmCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3Rvm3fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3Rvm3fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05321F000E9;
	Tue, 21 Jul 2026 23:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784677922;
	bh=XYN8f9351KWFfUArUzuNWsE73Ym72FcZGNNmApexyGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3Rvm3fVI8htPpnQ/F2ytZ3FU7ZNFrH2CIc4cyuf1q/fdwKwnduQu51H3ysvqAkMB
	 Q1KKixl5zk3jvHhOOV2F4E61EKZFa7oG/PA9706muY7ywY9BupuBgHDD1yNFnDGuaW
	 FGuR+FtkcAgBwN/SbyUjRawr/iiTB7Z4GYOEj7nFW4qSlnboRhZQncqQ6a3T5IRboD
	 TTYEibbrSoD+9YS4NmwdwSDjG3qRdSNdlczR0s9hxVfN02zuSM/QVkW0XjOzwAAQPe
	 Fz/PBD0+DGg/Arz4lLN5rGEfhlhLCW+hIAhRxbFdOa02AJQAHHyJh6v3Y+61aq0MVr
	 tLoHh40zwvoFA==
From: SJ Park <sj@kernel.org>
To: Hari Mishal <harimishal1@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Tue, 21 Jul 2026 16:51:52 -0700
Message-ID: <20260721235153.149569-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721190404.135937-1-harimishal1@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Hari,

On Tue, 21 Jul 2026 21:04:04 +0200 Hari Mishal <harimishal1@gmail.com> wrote:

> The obsolete_target test spawns three sh processes and uses their pids
> as DAMON monitoring targets.  These processes are created without their
> own stdin, so they inherit the test program's stdin, and they are never
> waited on or told to exit.  As a result, they are left running (or
> become zombies) as orphaned children after the test program exits.

Thank you for finding this problem and sharing this great patch!

> 
> Give each sh process its own dedicated stdin pipe instead of inheriting
> the test program's, and after the targets are no longer needed,
> communicate() with each process to close its stdin.  This sends EOF to
> the shell, which makes it exit, and communicate() then reaps the
> process.

Can't we use terminate() or kill() instead of communicate()?


Thanks,
SJ

[...]
