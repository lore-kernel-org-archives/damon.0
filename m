Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5F527589;
	Thu, 15 Oct 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072255; cv=none; b=ZzMHQt5Z/TABHTGlJhVzkphuHq2huE/1JbpCNhbIWuWtyU/If2nqNgd4+rZFvHY5WViD7fE0H24JEtIOcpP5buu2MHJqrgnP3Rm5SpI3p3Dqy+T54b5QZvvnuc8D9gdadTEiVQ54iBzEOj9+vMcC+lsixpIgoy3Lq28kFvr2p5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072255; c=relaxed/simple;
	bh=MUa9Dsa5psOCFn2+tB4jgmF7IVY2/hrNYnc8LGJu7Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkqXU7FSRywXJNJd66brajdGbb+UfHqZZKqBO5qWFfH5D7C1GOHxdSDvGMbKvpSKvl4icU34rfwEPNVA/D0Dqx9k1uCrnrdjva+WntVv7Kye/9fmraHxDXsSczgLYKJv5QwHg4/BOUlpxeXiN4eIs5GkvP4UsksTJoc7B4ayNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eep/pvRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eep/pvRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EA41F000C4;
	Thu, 15 Oct 2026 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072254;
	bh=Uky4LxVMuNdxzqnRXqwRhSpdCLtiXE4d97pVcYf0z28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eep/pvRWLeP7LUG6Llnfw1tNk6uZtNkk3PWjmeLelCpsn1VwxSQQqGifW+Owm3H68
	 O44r3hiFFVgv4vpz6w+heQRlMkDt5Zj6cqprL6FuxEy9maxJD8tFIUquiUdSOIkrnL
	 T+crrUqoslxVDIUyk6OPWTDrGs5YuMWlDbxhPO1Q95NT9LqXXVqM8Ahlhcex8ZFy8I
	 2lBEcO/zPkNSqULwIdy9zQQZq2C1pzRXAJ2H6vQDtd9Ihbgp4Qucoqv4ZeDbOn35AY
	 BX/hdcdohYwq9MHltL8ShzcHFu8YAJyO3H20ZhCKt0lyqDzyq7LdcwnHSpw0WJS+Rg
	 BTHUVNoYXbkQg==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/lru_sort: fix grammar and stlye
Date: Thu, 15 Oct 2026 06:50:46 -0700
Message-ID: <20261015135047.87355-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015072947.802821-2-manuelebnerli@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 09:29:47 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Fix tenses. Split long sentences thereby imporove readability.
> Replace 'set as' with 'set to'. Replace [] with () to make the file uniform.

checkpatch.pl warns as below.

    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
    #10:
    Replace 'set as' with 'set to'. Replace [] with () to make the file uniform.

If you don't mind, I will fix this on my end.

> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Assuming you don't mind me fixing the 75 columns warning on my end,

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree with the above mentioned commit
message line length fix.  We are now quite close to next merge window.  It may
better to focus on making mm.git more stabilized and therefore ready for the
next merge window, rather than adding more changes that are not really urgent.
I understand this series is not really urgent.  Hence, Andrew might not add
this patch until next -rc1 release.  In the case, I will request adding this to
mm.git after next -rc1 release.  So, no action from your side is needed for
now.  Let me know if you think this is really  urgent.

> ---

Please add changelog on the commentary area [2], with links to the previous
revisions, from the next time.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
[2] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
