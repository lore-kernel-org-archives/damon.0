Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E81BC20
	for <damon@lists.linux.dev>; Mon, 24 Jun 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255666; cv=none; b=ec+ihfCyLgwAHinkvpJhrhyraGMWgT4a3VC8MnaBzAEwUWqLp8CxuRHcodajgM1kX0iGf3n46A+Vxb1f2BgSIdaAVjESPc4+q6bMgayIuUmmmycutSPpAkquLmc1gvRmEuwn18gka6Vp4xyyU/YmIKdxRo8WGNw/WlmNBqQags0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255666; c=relaxed/simple;
	bh=4yRuOTFnzzPw+yAwkucTgu5txuvxd2pACCYHUKhCXg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JjbMhxfaPVwU5CyTCYZxRj2OFdWHT9eIH3mLhHU192BpHYtCvghZ0LhGKKS3cb7/M8TDLasjdaIl2HFOYxDrpVvCjUXt5b/xEmEbi1GmtpEPtUBEDwkwclwqwYtDidSflRFOO0RaN6EU7Glus7zBw8bu+Xlykj5TyePDfUIK4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8I3PcAB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8I3PcAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C9DC2BBFC;
	Mon, 24 Jun 2024 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255665;
	bh=4yRuOTFnzzPw+yAwkucTgu5txuvxd2pACCYHUKhCXg0=;
	h=From:To:Cc:Subject:Date:From;
	b=M8I3PcABf+QPzVnJVX+uJtsTptZqY45atcTiqVUbV6hpFfw3pnv+QmmnR/Ueoak5L
	 B93MPWRIyoG/mRu5yhqCkpTKvusK3voNvVnjSnwjbH2zcjRw1IxbbsxI45SZzKihZi
	 7xa+43ViiW3KXWcjICZFX+x21KrLmt/lEt5X7H3LYPy2DM/0azrQVDJAUYIVtfs5n1
	 dgHIziWNGQE7+LSwpTk/4P9G3PHpHjna3l+30EITDxNCaV/y6KOnkjDwINBj1/7ikS
	 4cITDTHIBXsVenFX7Svjki6rVklUBfDNbEbOalWpndtcN1REfygumN96ikth0yXnVD
	 yQHC68MSqrERQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Fwd: [PATCH 0/7] minor document fixups
Date: Mon, 24 Jun 2024 12:01:00 -0700
Message-Id: <20240624190100.96170-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I forgot Cc-ing damon@lists.linux.dev for the sixth patch.  Forwarding the mail
for future reference.

================================ 8< ===========================================

From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
CC: SeongJae Park <sj@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Alex Shi <alexs@kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, Bill Wendling <morbo@google.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, Federico Vaga <federico.vaga@vaga.pv.it>, Hu Haowen <2023002089@link.tyut.edu.cn>, Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, llvm@lists.linux.dev, workflows@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] minor document fixups
Message-Id: <20240624185312.94537-1-sj@kernel.org>
Date: Mon, 24 Jun 2024 11:53:05 -0700
Local-Date: 2024-06-24 11:53:05-07:00

This patch series is for minor document fixups.  First five patches
clean up and remove 'Other material' section of process/index in favor
of 'staging/' and better place for docs on the section.  A patch for
adding DAMON maintainer-profile reference on maintainers' handbook
follows.  And then the last patch adds 'hkml' as one of available email
tools on email-clients document.

SeongJae Park (7):
  Docs/process/index: Remove unaligned-memory-access from 'Other
    material'
  Docs/process/index: Remove riscv/patch-acceptance from 'Other
    material' section
  Docs: Move magic-number from process to staging
  Docs: Move clang-format from process/ to dev-tools/
  Docs/process/index: Remove unsorted docs section
  Docs/maintainer/maintainer-entry-profile: add DAMON maintainer profile
  Docs/process/email-clients: Document HacKerMaiL

 .clang-format                                         |  2 +-
 Documentation/{process => dev-tools}/clang-format.rst |  0
 Documentation/dev-tools/index.rst                     |  1 +
 Documentation/maintainer/maintainer-entry-profile.rst |  1 +
 Documentation/process/4.Coding.rst                    |  2 +-
 Documentation/process/coding-style.rst                |  2 +-
 Documentation/process/email-clients.rst               |  9 +++++++++
 Documentation/process/index.rst                       | 11 -----------
 Documentation/staging/index.rst                       |  1 +
 Documentation/{process => staging}/magic-number.rst   |  0
 .../translations/it_IT/process/clang-format.rst       |  2 +-
 .../translations/it_IT/process/magic-number.rst       |  2 +-
 .../translations/sp_SP/process/coding-style.rst       |  2 +-
 .../translations/sp_SP/process/magic-number.rst       |  2 +-
 Documentation/translations/zh_CN/process/4.Coding.rst |  2 +-
 .../translations/zh_CN/process/coding-style.rst       |  2 +-
 .../translations/zh_CN/process/magic-number.rst       |  2 +-
 Documentation/translations/zh_TW/process/4.Coding.rst |  2 +-
 .../translations/zh_TW/process/coding-style.rst       |  2 +-
 .../translations/zh_TW/process/magic-number.rst       |  2 +-
 20 files changed, 25 insertions(+), 24 deletions(-)
 rename Documentation/{process => dev-tools}/clang-format.rst (100%)
 rename Documentation/{process => staging}/magic-number.rst (100%)


base-commit: 88407e61007a3d3ebb62fc65479cc58d891ef74e
-- 
2.39.2
