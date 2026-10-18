Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B73A6F09;
	Sun, 18 Oct 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340618; cv=none; b=H8k3bXCA3nF/QdB0yxdlgT7YmF+8cYszGHIlS9KR78v2ihlVKweNADKMaE/5VpycOeY1kmPi2uaz6fM7j6rXfLTQedsQY1j9jdrxFB6h3eV81uucfy5fyq2IR5IgyB7Pel/ycrN0I0IUZkA7uqP+SvanFf0UHcqaXHQws246Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340618; c=relaxed/simple;
	bh=HwNXUeNKdwzjy+YPEJg5pGa3SbGf1bmlntlDyn92vb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl4flpw0LK/FntQbRk29nHSd2gdrNlm3sFNUiQZyL3u4hIQOrkmfdg7dgpwCAzMXUJyl+h55O63Mg6LAhAEbAmTfUhLU54Ce78vVxDxQm0MCkKrHQkZikZ5NVVTKbl0s6UkphFn5Tk2ECUHnmTzfsKEHycNrQdzkMLR/DVPGty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6pSUoE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6pSUoE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40A31F000C4;
	Sun, 18 Oct 2026 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792340617;
	bh=PkvCnZp3GqJK4bIvD1zVQOPN0TOHqm9DCWSAjzxS07o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6pSUoE0uF9R61EmmdJ/FHRrRUP+N3n8/JOStw3k3xMxktDAZ9yjDt6raMWvnFs5r
	 uTBxSI4ODXNjzZWV+iMaAY5Eo8+aNEsYoWI9w4fR2/Mx742HJQvD88czJXIG0UJtsh
	 E4N8qevijiTh2YnwIrS1lvZ8QSi6b+vRnZ4QDROCVGvM61VF+F9VPLf/CzITV4Tf71
	 YMYMWbfXe7eYuGr/tZ7sJJHWKWr4My4sbUy0KPpN89fyQTXNuaOfwYCjuEsQtHIqYm
	 vvEI3gAzUDGrzJ1FDtwWyABA2tdZQz2OtJZcNmI8+E8YWx3n9joQ4Y206uVsHG1INU
	 Ifk14sum/ay8g==
From: SJ Park <sj@kernel.org>
To: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon/sysfs.py: stop obsolete_target shells hanging the test
Date: Sun, 18 Oct 2026 09:23:29 -0700
Message-ID: <20261018162330.107844-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018020415.35567-1-jaeyeon.lee.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 18 Oct 2026 04:04:15 +0200 Jaeyeon Lee <jaeyeon.lee.dev@gmail.com> wrote:

> The obsolete_target test spawns three 'sh' processes as monitoring
> targets.  The processes inherit stdin from the test.  When the test is
> run via 'make run_tests' from an interactive terminal, the kselftest
> runner executes it under 'timeout', which puts it in a background
> process group.  The 'sh' processes then try to read the terminal, so
> the kernel sends SIGTTIN to the whole process group.  This stops the
> 'sh' processes, and also the child the test has just forked to spawn
> the next 'sh', before it can run 'sh'.  The test then waits on that
> child forever, until the kselftest runner kills it after 45 seconds.
> The test passes when run directly.
> 
> Fix this by passing stdin=subprocess.PIPE when spawning the processes.
> The processes then read from a pipe that never receives input, so they
> stay alive and idle as the test expects.

Thank you for finding and fixing the bug!

> 
> Assisted-by: LLM
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  It may better to focus on making mm.git more stabilized and
therefore ready for the next merge window, rather than adding more changes that
are not really urgent.  I understand this series is not really urgent.  Hence,
Andrew might not add this patch until next -rc1 release.  In the case, I will
request adding this to mm.git after next -rc1 release.  So, no action from your
side is needed for now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
