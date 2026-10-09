Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59935364949
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554086; cv=none; b=rgfUCG82J2Ykv5POPxpaoSJvZtHxRhazHdsqLqkhviQnQS+MHj6lTsVViaddkn+1sJaLWF+fSu/Et6hNpklmM8QBNLH0yWQFImKBTDXjHo6BgUWBMM8MymOZzn9G6uZfn664dmQfRNDEmDXa5KKQ9XXZQDfQUf6C+2wXUCz50Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554086; c=relaxed/simple;
	bh=Ew3EUnsOWlpKlB82nSC05WjDNWjDh7KAmjT1x/dgdxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIV7Ge2JGZ+rtnRV+vNlqx2e+V7AEGR9n9RMSa7+/o0x7gCgjFVoBWE/SSCbB0RoGhmkUWFmTvrm/p1o3tMxnUGgUnDdCKDe05eVbVpHRAtL8SvLn0/xxbf3REw3moFnR/ozLi/y3n8OOiZi4OeoZoTY466aOw+BV4SyCzh4JuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIEiTfVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIEiTfVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA3A1F00898;
	Fri,  9 Oct 2026 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554085;
	bh=MPhGoc9Ld/Il9e/6OU3y+ZCWOjT8Q9T6KXbN4b5BmK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIEiTfVeOUBYhEaPTgJLU/abBGXVDkI4kP9nKe+MqxDPFQ6nHUQ6hNkmFfLwwmz9o
	 nGoqWZ7a3NQ48BjLOq4e9s+KJUOPmASQ+ZFvGipN3NOtoLUH9LCEqwIfXhwhBU/Arm
	 buY0gkD0OQijkFM8MED9Ef78i3Zn0ksRTp7X/ZG4NsWDwd3uBQdI38VQIcR9tSGt3v
	 pc4woBJhDxqQRaYv8dTp0CuQyjA/K5XNHPYZx0EhPk9qYGFnobS8cg5hLcCYIGbkmv
	 PJDlua/y12fmQHIbEqff14pWYJPwInhaNDr+0eELcwU1tEALjCw6cjAB+kuBymRPD+
	 Y0HoaAxRQ1/7Q==
From: SJ Park <sj@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: SJ Park <sj@kernel.org>,
	Arnav Goel <ArnavGoel@woodstock.ac.in>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: =?UTF-8?q?Re=3A=20Research=20use=20of=20D=C4=80MOS=20Linear=20B=20texts?=
Date: Fri,  9 Oct 2026 06:54:40 -0700
Message-ID: <20261009135441.11570-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <asjh_RkmMyEUZUiP@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 9 Oct 2026 13:45:49 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Oct 09, 2026 at 05:42:41AM +0000, Arnav Goel wrote:
> > Dear DĀMOS team,
> > 
> > I am a high school student in India building a benchmark that tests decipherment methods on short-text corpora. Linear B would be an ideal real-world check, since its texts are short and its language is known.
> > 
> > I understand DĀMOS is available under CC BY-NC-SA 4.0. Is there a way to export the transliterated texts in bulk for non-commercial research use? I would cite DĀMOS fully and not redistribute the data beyond what the licence allows.
> 
> I'm afraid you're asking the wrong people.  This is the Linux DAMOS
> which is a Data Access Monitoring tool.  You should probably be talking
> to these people instead:
> 
> https://damos.hf.uio.no/about/content/

Thank you for kindly explaining that and Cc-ing damon@, Matthew.  Arnav, as
Matthew mentioned, seems you are using a wrong contact point.


Thanks,
SJ
